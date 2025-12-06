import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'glass_panel_style.dart';
part 'glass_panel_animation.dart';

class GlassPanel extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final bool animated;

  const GlassPanel({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.animated = false,
  });

  @override
  Widget build(BuildContext context) {
    final panel = Container(
      width: width ?? 0.88.sw,
      height: height,
      padding: EdgeInsets.all(20.w),
      decoration: GlassPanelStyle.defaultDecoration,
      child: child,
    );

    return !animated ? panel : GlassPanelAnimation(child: panel);
  }
}
