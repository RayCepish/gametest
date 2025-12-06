import 'package:flutter/material.dart';
import 'package:game_test/core/widgets/animated_button/render_shimmer.dart';

class ShimmerEffect extends LeafRenderObjectWidget {
  final double progress;
  final Color color;
  final double opacity;

  const ShimmerEffect({
    super.key,
    required this.progress,
    this.color = const Color(0xFFFFFFFF),
    this.opacity = 0.2,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderShimmer(progress: progress, color: color, opacity: opacity);
  }

  @override
  void updateRenderObject(BuildContext context, RenderShimmer renderObject) {
    renderObject.progress = progress;
  }
}
