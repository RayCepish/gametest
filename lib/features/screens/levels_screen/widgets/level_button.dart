import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/constants/app_images.dart';
import 'package:game_test/core/widgets/stroke_text.dart';
import 'package:game_test/features/screens/levels_screen/widgets/button_filters.dart';
import 'package:go_router/go_router.dart';

class LevelButton extends StatelessWidget {
  final int number;
  final bool unlocked;
  final int requiredEggs;
  final VoidCallback? onTap;

  const LevelButton({
    super.key,
    required this.number,
    required this.unlocked,
    required this.requiredEggs,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unlocked
          ? onTap
          : () {
              context.goNamed("store");
            },
      child: unlocked ? _buildUnlocked() : _buildLocked(),
    );
  }

  Widget _buildUnlocked() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(AppImages.emptyFrame, width: 95.w),
        StrokeText("$number", fontSize: 32.sp),
      ],
    );
  }

  Widget _buildLocked() {
    return Stack(
      alignment: Alignment.center,
      children: [
        ColorFiltered(
          colorFilter: grayslakeFrameFilter,
          child: Opacity(
            opacity: 0.5,
            child: Image.asset(AppImages.emptyFrame, width: 95.w),
          ),
        ),

        ColorFiltered(
          colorFilter: grayslakeEggFilter,
          child: Image.asset(AppImages.egg1, width: 40.w),
        ),

        Positioned(
          bottom: 12.h,
          child: StrokeText(
            "$requiredEggs",
            fontSize: 22.sp,
            strokeColor: Colors.black,
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
