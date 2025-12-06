import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/constants/app_images.dart';
import 'package:game_test/core/services/level_service.dart';
import 'package:game_test/core/widgets/game_app_bar/game_app_bar.dart';
import 'package:game_test/core/widgets/layouts/main_layout.dart';
import 'package:game_test/core/widgets/stroke_text.dart';
import 'package:game_test/features/cubbits/user_cubit/user_cubit.dart';
import 'package:game_test/features/screens/levels_screen/widgets/level_button.dart';
import 'package:go_router/go_router.dart';

class LevelsScreen extends StatelessWidget {
  const LevelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state.user;
    final eggsCount = user.eggs.length;

    return MainLayout(
      appBar: GameAppBar(
        leftButtonImage: AppImages.btnBack,
        onLeftTap: () => context.pop(),
        showCoins: true,
        onCoinsTap: () => context.goNamed('store'),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: Column(
          children: [
            StrokeText("CHANGE LEVEL", fontSize: 32.sp),
            StrokeText("OWNED EGGS $eggsCount", fontSize: 20.sp),
            SizedBox(height: 20.h),

            Expanded(
              child: Center(
                child: Wrap(
                  spacing: 25.w,
                  runSpacing: 25.h,
                  children: List.generate(12, (index) {
                    final level = index + 1;

                    final unlocked = LevelService.isLevelUnlocked(
                      level: level,
                      eggsCount: eggsCount,
                    );

                    final required = LevelService.eggsRequiredForLevel(level);

                    final missing = max(required - eggsCount, 0);

                    return LevelButton(
                      number: unlocked ? level : missing,
                      unlocked: unlocked,
                      requiredEggs: required,
                      onTap: () {
                        if (unlocked) {
                          context.goNamed('game', extra: level);
                        }
                      },
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
