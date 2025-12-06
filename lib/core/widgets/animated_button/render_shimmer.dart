import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';

class RenderShimmer extends RenderProxyBox {
  RenderShimmer({
    required this.progress,
    required this.color,
    required this.opacity,
  });

  double progress;
  final Color color;
  final double opacity;

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);

    final rect = offset & size;

    final shimmerPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(
          rect.left - rect.width * 2 + rect.width * progress * 4,
          rect.top,
        ),
        Offset(
          rect.right + rect.width * 2 + rect.width * progress * 4,
          rect.bottom,
        ),
        [
          color.withOpacity(0.0),
          color.withOpacity(opacity),
          color.withOpacity(0.0),
        ],
        [0.25, 0.5, 0.75],
      );

    context.canvas.drawRect(rect, shimmerPaint);
  }
}
