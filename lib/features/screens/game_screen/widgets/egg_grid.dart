import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/constants/egg_config.dart';
import 'package:game_test/features/cubbits/game_cubit/game_state.dart';
import 'package:game_test/features/screens/game_screen/widgets/egg_animated_item.dart';

class EggGrid extends StatelessWidget {
  final List<int> eggs;
  final Map<int, EggHighlightState> eggStates;
  final bool inputEnabled;
  final ValueChanged<int> onTap;

  const EggGrid({
    super.key,
    required this.eggs,
    required this.eggStates,
    required this.inputEnabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = (sqrt(eggs.length).ceil()).clamp(2, 4);

    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
      ),
      itemCount: eggs.length,
      itemBuilder: (_, index) {
        final eggId = eggs[index];
        final config = getEggById(eggId);
        final state = eggStates[eggId] ?? EggHighlightState.none;

        return EggAnimatedItem(
          eggId: eggId,
          asset: config.asset,
          state: state,
          tapEnabled: inputEnabled,
          onTap: onTap,
        );
      },
    );
  }
}
