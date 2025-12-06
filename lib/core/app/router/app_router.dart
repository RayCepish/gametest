import 'package:flutter/material.dart';
import 'package:game_test/core/app/router/router_transitions.dart';
import 'package:game_test/features/screens/game_screen/game_screen.dart';
import 'package:game_test/features/screens/how_to_play_screen/how_to_play_screen.dart';
import 'package:game_test/features/screens/leaderboard_screen/leaderboard_screen.dart';
import 'package:game_test/features/screens/levels_screen/levels_screen.dart';
import 'package:game_test/features/screens/menu_screen/menu_screen.dart';
import 'package:game_test/features/screens/privacy_policy_screen/privacy_policy_screen.dart';
import 'package:game_test/features/screens/profile_screen/profile_screen.dart';
import 'package:game_test/features/screens/setting_screen/settings_screen.dart';
import 'package:game_test/features/screens/store_screen/store_screen.dart';
import 'package:game_test/features/screens/terms_of_use_screen.dart/terms_of_use_screen.dart';
import 'package:game_test/features/screens/main_app_screen/main_app_screen.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'welcome',
        pageBuilder: (context, state) =>
            RouterTransitions.fade(const MainAppScreen(), state),
        routes: [
          GoRoute(
            path: 'how-to-play',
            name: 'how_to_play',
            pageBuilder: (context, state) =>
                RouterTransitions.fade(const HowToPlayScreen(), state),
          ),

          GoRoute(
            path: 'levels',
            name: 'levels',
            pageBuilder: (context, state) =>
                RouterTransitions.slideLeft(const LevelsScreen(), state),
            routes: [
              GoRoute(
                path: 'store',
                name: 'store',
                pageBuilder: (context, state) =>
                    RouterTransitions.slideLeft(const StoreScreen(), state),
              ),

              GoRoute(
                path: 'game',
                name: 'game',
                pageBuilder: (context, state) {
                  final level = state.extra as int;
                  return RouterTransitions.slideLeft(
                    GameScreen(level: level),
                    state,
                  );
                },
              ),
            ],
          ),

          GoRoute(
            path: 'menu',
            name: 'menu',
            pageBuilder: (context, state) =>
                RouterTransitions.fade(const MenuScreen(), state),
            routes: [
              GoRoute(
                path: 'profile',
                name: 'profile',
                pageBuilder: (context, state) =>
                    RouterTransitions.slideLeft(const ProfileScreen(), state),
              ),
              GoRoute(
                path: 'settings',
                name: 'settings',
                pageBuilder: (context, state) =>
                    RouterTransitions.slideLeft(const SettingsScreen(), state),
              ),
              GoRoute(
                path: 'leaderboard',
                name: 'leaderboard',
                pageBuilder: (context, state) => RouterTransitions.slideLeft(
                  const LeaderboardScreen(),
                  state,
                ),
              ),
              GoRoute(
                path: 'privacy',
                name: 'privacy',
                pageBuilder: (context, state) => RouterTransitions.slideLeft(
                  const PrivacyPolicyScreen(),
                  state,
                ),
              ),
              GoRoute(
                path: 'terms',
                name: 'terms',
                pageBuilder: (context, state) => RouterTransitions.slideLeft(
                  const TermsOfUseScreen(),
                  state,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
