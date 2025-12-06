import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/services/vibration_service.dart';
import 'package:game_test/dependency_injection/setup_dependency.dart';
import 'package:game_test/features/cubbits/game_cubit/game_state.dart';

class EggAnimatedItem extends StatefulWidget {
  final int eggId;
  final String asset;
  final EggHighlightState state;
  final bool tapEnabled;
  final ValueChanged<int> onTap;

  const EggAnimatedItem({
    super.key,
    required this.eggId,
    required this.asset,
    required this.state,
    required this.tapEnabled,
    required this.onTap,
  });

  @override
  State<EggAnimatedItem> createState() => _EggAnimatedItemState();
}

class _EggAnimatedItemState extends State<EggAnimatedItem> {
  double scale = 1.0;
  double glowOpacity = 0.0;
  Color glowColor = Colors.transparent;

  @override
  void initState() {
    super.initState();

    if (widget.state != EggHighlightState.none) {
      glowColor = _colorForState(widget.state);
      WidgetsBinding.instance.addPostFrameCallback((_) => _animateGlow());
    }
  }

  @override
  void didUpdateWidget(covariant EggAnimatedItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.state == oldWidget.state) return;

    switch (widget.state) {
      case EggHighlightState.highlight:
        glowColor = Colors.purpleAccent;
        _animateGlow();
        break;

      case EggHighlightState.correct:
        glowColor = Colors.greenAccent;
        getIt<VibrationService>().vibrateLight();
        _animateGlow();
        break;

      case EggHighlightState.wrong:
        glowColor = Colors.redAccent;
        getIt<VibrationService>().vibrateStrong();
        _animateGlow();
        break;

      case EggHighlightState.none:
        glowOpacity = 0;
        break;
    }
  }

  Color _colorForState(EggHighlightState state) {
    switch (state) {
      case EggHighlightState.highlight:
        return Colors.purpleAccent;
      case EggHighlightState.correct:
        return Colors.greenAccent;
      case EggHighlightState.wrong:
        return Colors.redAccent;
      case EggHighlightState.none:
        return Colors.transparent;
    }
  }

  Future<void> _animateGlow() async {
    setState(() {
      glowOpacity = 1.0;
      scale = 1.2;
    });

    await Future.delayed(const Duration(milliseconds: 160));

    if (!mounted) return;

    setState(() {
      glowOpacity = 0.0;
      scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.tapEnabled ? () => widget.onTap(widget.eggId) : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
            opacity: glowOpacity,
            duration: const Duration(milliseconds: 160),
            child: Container(
              width: 140.w,
              height: 160.h,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: glowColor.withOpacity(0.3),
                    blurRadius: 35,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
          ),

          AnimatedScale(
            scale: scale,
            duration: const Duration(milliseconds: 160),
            curve: Curves.easeOut,
            child: Image.asset(widget.asset),
          ),
        ],
      ),
    );
  }
}
