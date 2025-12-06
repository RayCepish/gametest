// game_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:game_test/core/constants/app_images.dart';
import 'package:game_test/core/widgets/game_app_bar/game_app_bar.dart';
import 'package:game_test/core/widgets/glass_panel/glass_panel.dart';
import 'package:game_test/core/widgets/layouts/game_layout.dart';
import 'package:game_test/core/widgets/stroke_text.dart';
import 'package:game_test/features/cubbits/game_cubit/game_cubit.dart';
import 'package:game_test/features/cubbits/game_cubit/game_state.dart';
import 'package:game_test/features/screens/game_screen/widgets/egg_grid.dart';
import 'package:game_test/features/screens/game_screen/widgets/hearts_mistakes_indicator.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        final cubit = context.read<GameCubit>();
        final isCountdownPhase =
            state.phase == GamePhase.countdown ||
            state.phase == GamePhase.repeatCountdown;

        return GameLayout(
          appBar: GameAppBar(
            leftButtonImage: AppImages.btnBack,
            onLeftTap: () => Navigator.of(context).pop(),
            rightButtonImage: AppImages.btnPause,
            showCoins: true,
            onRightTap: cubit.pause,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 16.h),

                  GlassPanel(
                    width: 0.9.sw,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StrokeText(
                          "SEQUENCE ${state.sequenceNumber}/3",
                          fontSize: 18.sp,
                        ),

                        HeartsMistakesIndicator(
                          mistakes: state.mistakes,
                          maxMistakes: GameCubit.maxMistakes,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  if (!isCountdownPhase)
                    Expanded(
                      child: Center(
                        child: EggGrid(
                          eggs: state.eggs,
                          eggStates: state.eggStates,
                          inputEnabled: state.isInputEnabled,
                          onTap: cubit.onPlayerTapEgg,
                        ),
                      ),
                    ),
                ],
              ),

              if (isCountdownPhase)
                Positioned.fill(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (state.phase == GamePhase.repeatCountdown)
                          Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: StrokeText("REPEAT!", fontSize: 26.sp),
                          ),
                        AnimatedScale(
                          scale: 1.2,
                          duration: const Duration(milliseconds: 250),
                          child: StrokeText(
                            "${state.countdown}",
                            fontSize: 90.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
