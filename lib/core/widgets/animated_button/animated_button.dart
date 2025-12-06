import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/widgets/animated_button/shimmer_effect.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

part 'pulse_animation_config.dart';
part 'shimmer_animation_config.dart';

enum AnimatedButtonStyle { soft, medium, strong, randomShimmer }

class AnimatedButton extends StatefulWidget {
  final String imagePath;
  final double width;
  final VoidCallback onTap;

  final PulseAnimationConfig pulseAnimationConfig;
  final ShimmerAnimationConfig shimmerAnimationConfig;

  const AnimatedButton({
    super.key,
    required this.imagePath,
    required this.onTap,
    this.width = 260,
    this.pulseAnimationConfig = PulseAnimationConfig.medium,
    this.shimmerAnimationConfig = const ShimmerAnimationConfig(),
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  AnimationController? _pulseController;
  late AnimationController _shimmerController;

  late Animation<double> _pulse;
  late Animation<double> _shimmer;

  bool get hasPulse => widget.pulseAnimationConfig.duration != null;

  @override
  void initState() {
    super.initState();

    // --- Pulse animation ---
    if (hasPulse) {
      _pulseController = AnimationController(
        vsync: this,
        duration: widget.pulseAnimationConfig.duration!,
      )..repeat(reverse: true);

      _pulse =
          Tween<double>(
            begin: widget.pulseAnimationConfig.minScale,
            end: widget.pulseAnimationConfig.maxScale,
          ).animate(
            CurvedAnimation(parent: _pulseController!, curve: Curves.easeInOut),
          );
    } else {
      _pulse = const AlwaysStoppedAnimation(1.0);
    }

    // --- Shimmer animation ---
    _shimmerController = AnimationController(
      vsync: this,
      duration: widget.shimmerAnimationConfig.interval,
    )..repeat();

    _shimmer = Tween<double>(begin: 0, end: 1).animate(_shimmerController);
  }

  @override
  void dispose() {
    _pulseController?.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        if (_pulseController != null) _pulseController!,
        _shimmerController,
      ]),
      builder: (_, __) {
        return Transform.scale(
          scale: _pulse.value,
          child: GestureDetector(
            onTapDown: (_) {
              _pulseController?.stop();
            },
            onTapUp: (_) {
              if (_pulseController != null) {
                _pulseController!.repeat(reverse: true);
              }
              widget.onTap();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.r),
              child: Stack(
                children: [
                  Image.asset(widget.imagePath, width: widget.width.w),
                  Positioned.fill(
                    child: ShimmerEffect(progress: _shimmer.value),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
