import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/constants/app_images.dart';
import 'package:game_test/core/widgets/animated_button/animated_button.dart';

import 'package:game_test/core/widgets/game_app_bar/game_app_bar.dart';
import 'package:game_test/core/widgets/glass_panel/glass_panel.dart';
import 'package:game_test/core/widgets/layouts/main_layout.dart';
import 'package:game_test/core/widgets/stroke_text.dart';
import 'package:go_router/go_router.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const pulse = PulseAnimationConfig.soft;
    final buttons = [
      (AppImages.btnProfile, () => context.pushNamed('profile')),
      (AppImages.btnSettings, () => context.pushNamed('settings')),
      (AppImages.btnLeaderboard, () => context.pushNamed('leaderboard')),
      (AppImages.btnPrivacyPolicy, () => context.pushNamed('privacy')),
      (AppImages.btnTermsOfUse, () => context.pushNamed('terms')),
    ];

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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StrokeText("MENU", fontSize: 32.sp),

              ...buttons.map(
                (item) => AnimatedButton(
                  width: 170.w,
                  imagePath: item.$1,
                  onTap: item.$2,
                  pulseAnimationConfig: pulse,
                  shimmerAnimationConfig: ShimmerAnimationConfig.random(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
