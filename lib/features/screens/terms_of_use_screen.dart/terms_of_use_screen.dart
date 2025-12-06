import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/constants/app_images.dart';
import 'package:game_test/core/widgets/game_app_bar/game_app_bar.dart';
import 'package:game_test/core/widgets/glass_panel/glass_panel.dart';
import 'package:game_test/core/widgets/layouts/main_layout.dart';
import 'package:game_test/core/widgets/stroke_text.dart';
import 'package:go_router/go_router.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

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
              StrokeText("TERMS OF USE", fontSize: 28.sp),
              SizedBox(height: 20.h),

              StrokeText("This game is for entertainment.", fontSize: 18.sp),
              StrokeText("Use it at your own discretion.", fontSize: 18.sp),
              SizedBox(height: 12.h),

              StrokeText("Game data is stored locally", fontSize: 18.sp),
              StrokeText("and may be erased if uninstalled.", fontSize: 18.sp),
              SizedBox(height: 12.h),

              StrokeText("Do not modify or redistribute", fontSize: 18.sp),
              StrokeText("the game's files.", fontSize: 18.sp),
              SizedBox(height: 12.h),

              StrokeText("By playing, you agree", fontSize: 18.sp),
              StrokeText("to these rules.", fontSize: 18.sp),
            ],
          ),
        ),
      ),
    );
  }
}
