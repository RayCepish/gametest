import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/constants/app_images.dart';
import 'package:game_test/core/widgets/game_app_bar/game_app_bar.dart';
import 'package:game_test/core/widgets/glass_panel/glass_panel.dart';
import 'package:game_test/core/widgets/layouts/main_layout.dart';
import 'package:game_test/core/widgets/stroke_text.dart';
import 'package:go_router/go_router.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          child: Column(
            children: [
              StrokeText("PRIVACY POLICY", fontSize: 28.sp),
              SizedBox(height: 20.h),

              StrokeText("We respect your privacy.", fontSize: 18.sp),
              StrokeText("No personal data is collected.", fontSize: 18.sp),
              SizedBox(height: 12.h),

              StrokeText("Your progress is stored locally", fontSize: 18.sp),
              StrokeText("on your device only.", fontSize: 18.sp),
              SizedBox(height: 12.h),

              StrokeText("We do not share your data", fontSize: 18.sp),
              StrokeText("with any third parties.", fontSize: 18.sp),
              SizedBox(height: 12.h),

              StrokeText("Deleting the game may remove", fontSize: 18.sp),
              StrokeText("your saved progress.", fontSize: 18.sp),
              SizedBox(height: 16.h),

              StrokeText("Thanks for playing!", fontSize: 18.sp),
            ],
          ),
        ),
      ),
    );
  }
}
