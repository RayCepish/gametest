import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/constants/app_images.dart';
import 'package:game_test/core/widgets/animated_button/animated_button.dart';
import 'package:game_test/core/widgets/glass_panel/glass_panel.dart';
import 'package:game_test/core/widgets/layouts/score_box_simple.dart';
import 'package:game_test/core/widgets/stroke_text.dart';
import 'package:game_test/features/cubbits/game_cubit/game_cubit.dart';
import 'package:game_test/features/cubbits/game_cubit/game_state.dart';
import 'package:game_test/features/cubbits/user_cubit/user_cubit.dart';
import 'package:go_router/go_router.dart';

class GameOverlayLayer extends StatefulWidget {
  final GameState state;
  final GameCubit cubit;

  const GameOverlayLayer({super.key, required this.state, required this.cubit});

  @override
  State<GameOverlayLayer> createState() => _GameOverlayLayerState();
}

class _GameOverlayLayerState extends State<GameOverlayLayer> {
  bool showWarning = false;

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final cubit = widget.cubit;

    final isWin = state.overlay == GameOverlayType.win;
    final isLose = state.overlay == GameOverlayType.lose;
    final isPaused = state.overlay == GameOverlayType.paused;

    final nextLevel = state.level + 1;
    final eggsCount = context.watch<UserCubit>().state.user.eggs.length;
    final requiredEggs = nextLevel + 2;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black54,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StrokeText(
            isWin
                ? "YOU WIN!"
                : isLose
                ? "YOU LOSE!"
                : "PAUSED",
            fontSize: 48.sp,
          ),

          SizedBox(height: 30.h),

          if (!isPaused) ...[
            ScoreBoxSimple(label: "SCORE", value: state.score),
            SizedBox(height: 18.h),
            ScoreBoxSimple(
              label: "BEST",
              value: context.watch<UserCubit>().state.user.bestScore,
            ),
          ],

          SizedBox(height: 35.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: StrokeText("HOME", fontSize: 26.sp, underline: true),
                ),
              ),

              if (!isLose)
                GestureDetector(
                  onTap: cubit.restart,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: StrokeText(
                      "RESTART",
                      fontSize: 26.sp,
                      underline: true,
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(height: 30.h),

          if (showWarning)
            _EggWarningBanner(
              requiredEggs: requiredEggs,
              onShopTap: () => context.goNamed('store'),
            ),

          SizedBox(height: 20.h),

          if (isWin)
            AnimatedButton(
              imagePath: AppImages.btnNext,
              width: 260.w,
              onTap: () {
                final canPlay = eggsCount >= requiredEggs;

                if (!canPlay) {
                  setState(() => showWarning = true);
                  return;
                }

                context.goNamed('game', extra: nextLevel);
              },
            )
          else if (isLose)
            AnimatedButton(
              imagePath: AppImages.btnTryAgain,
              width: 260.w,
              onTap: cubit.restart,
            )
          else
            AnimatedButton(
              imagePath: AppImages.btnPlay,
              width: 260.w,
              onTap: cubit.resume,
            ),
        ],
      ),
    );
  }
}

class _EggWarningBanner extends StatelessWidget {
  final int requiredEggs;
  final VoidCallback onShopTap;

  const _EggWarningBanner({
    required this.requiredEggs,
    required this.onShopTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      child: Column(
        children: [
          StrokeText("Not enough eggs", fontSize: 26.sp),
          SizedBox(height: 6.h),
          Text(
            "You need $requiredEggs eggs to unlock next level.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: onShopTap,
            child: StrokeText("VISIT SHOP", fontSize: 24.sp, underline: true),
          ),
        ],
      ),
    );
  }
}
