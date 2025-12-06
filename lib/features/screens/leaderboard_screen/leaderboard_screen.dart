import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/constants/app_images.dart';
import 'package:game_test/core/widgets/game_app_bar/game_app_bar.dart';
import 'package:game_test/core/widgets/glass_panel/glass_panel.dart';
import 'package:game_test/core/widgets/layouts/main_layout.dart';
import 'package:game_test/core/widgets/stroke_text.dart';
import 'package:game_test/dependency_injection/setup_dependency.dart';
import 'package:game_test/features/cubbits/leaderboard_cubit/leaderboard_cubit.dart';
import 'package:game_test/features/screens/leaderboard_screen/widgets/leaderboard_tile.dart';
import 'package:go_router/go_router.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LeaderboardCubit>()..load(),
      child: BlocBuilder<LeaderboardCubit, LeaderboardState>(
        builder: (context, state) {
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
                    StrokeText("LEADERBOARD", fontSize: 28.sp),
                    SizedBox(height: 20.h),

                    if (state is LeaderboardLoading)
                      const Center(child: CircularProgressIndicator()),

                    if (state is LeaderboardLoaded)
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: state.users.length,
                          itemBuilder: (_, i) {
                            final user = state.users[i];
                            final isCurrent =
                                user.profile.name ==
                                state.currentUser.profile.name;

                            return Padding(
                              padding: EdgeInsets.only(bottom: 1.h),
                              child: LeaderboardTile(
                                username: user.profile.name!,
                                score: user.bestScore.toString(),
                                isCurrentUser: isCurrent,
                                avatar: user.profile.avatarPath,
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
