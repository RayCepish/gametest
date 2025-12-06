import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_test/core/constants/app_images.dart';
import 'package:game_test/core/widgets/layouts/static_background.dart';
import 'package:game_test/features/cubbits/game_cubit/game_cubit.dart';
import 'package:game_test/features/cubbits/game_cubit/game_state.dart';
import 'package:game_test/core/widgets/layouts/game_overlay_layer.dart';

class GameLayout extends StatelessWidget {
  final Widget child;
  final Widget? appBar;

  const GameLayout({super.key, required this.child, this.appBar});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<GameCubit>();
    final state = cubit.state;

    return Scaffold(
      body: Stack(
        children: [
          StaticBackground(image: AppImages.bgAction),

          if (appBar != null)
            Positioned(
              top: MediaQuery.of(context).padding.top + 12,
              left: 20,
              right: 20,
              child: appBar!,
            ),

          Positioned.fill(
            child: Column(
              children: [
                SizedBox(height: appBar != null ? 110 : 0),
                Expanded(child: child),
              ],
            ),
          ),

          if (state.overlay != GameOverlayType.none)
            Positioned.fill(
              child: GameOverlayLayer(state: state, cubit: cubit),
            ),
        ],
      ),
    );
  }
}
