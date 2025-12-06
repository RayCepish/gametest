import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/constants/app_images.dart';
import 'package:game_test/core/widgets/game_app_bar/game_app_bar.dart';
import 'package:game_test/core/widgets/glass_panel/glass_panel.dart';
import 'package:game_test/core/widgets/layouts/main_layout.dart';
import 'package:game_test/core/widgets/stroke_text.dart';
import 'package:go_router/go_router.dart';

class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBar: GameAppBar(
        leftButtonImage: AppImages.btnBack,
        onLeftTap: () => context.pop(),
      ),

      child: Padding(
        padding: EdgeInsets.only(top: 40.h, bottom: 40.h),
        child: GlassPanel(
          animated: true,
          child: Column(
            children: [
              StrokeText("HOW TO PLAY", fontSize: 28.sp),
              SizedBox(height: 20.h),

              StrokeText("Remember the glowing eggs.", fontSize: 18.sp),
              StrokeText("Repeat the sequence in order.", fontSize: 18.sp),
              SizedBox(height: 12.h),

              StrokeText("Each round adds a new step.", fontSize: 18.sp),
              StrokeText("Focus and don't lose track!", fontSize: 18.sp),
              SizedBox(height: 16.h),

              StrokeText("You have 3 lives.", fontSize: 20.sp),
              StrokeText("Mistakes reduce your chances.", fontSize: 18.sp),
              SizedBox(height: 16.h),

              StrokeText("Complete all sequences to win!", fontSize: 18.sp),
            ],
          ),
        ),
      ),
    );
  }
}
