import 'package:flutter/material.dart';
import 'package:game_test/core/constants/app_images.dart';

class ChickenAnimated extends StatelessWidget {
  const ChickenAnimated({
    super.key,
    required this.scaleAnimation,
    required this.slideAnimation,
  });

  final Animation<double> scaleAnimation;
  final Animation<Offset> slideAnimation;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SlideTransition(
          position: slideAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: const Image(
              image: AssetImage(AppImages.chick2),
              height: 620,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
