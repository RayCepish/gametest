import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/widgets/game_app_bar/coins_display.dart';
import 'package:game_test/features/cubbits/user_cubit/user_cubit.dart';

part 'game_app_bar_buttons.dart';

class GameAppBar extends StatelessWidget {
  final String? leftButtonImage;
  final VoidCallback? onLeftTap;

  final String? rightButtonImage;
  final VoidCallback? onRightTap;

  final bool showCoins;
  final VoidCallback? onCoinsTap;

  const GameAppBar({
    super.key,
    this.leftButtonImage,
    this.onLeftTap,
    this.rightButtonImage,
    this.onRightTap,
    this.showCoins = false,
    this.onCoinsTap,
  });

  @override
  Widget build(BuildContext context) {
    final gold = context.watch<UserCubit>().state.user.gold;

    final hasLeft = leftButtonImage != null;
    final hasRight = rightButtonImage != null;
    final hasCoins = showCoins;

    final left = hasLeft
        ? AppBarButton(image: leftButtonImage!, onTap: onLeftTap)
        : SizedBox(width: 50.w);

    final right = hasRight
        ? AppBarButton(image: rightButtonImage!, onTap: onRightTap)
        : SizedBox(width: 50.w);

    final coins = GestureDetector(
      onTap: onCoinsTap,
      child: CoinsDisplay(value: gold),
    );

    if (hasLeft && hasRight && hasCoins) {
      return Row(
        children: [
          left,
          Expanded(child: Center(child: coins)),
          right,
        ],
      );
    }

    if (!hasRight && hasCoins) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          left,
          Row(
            children: [
              coins,
              SizedBox(width: 20.w), // 👈 Додаємо відступ справа
            ],
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        left,
        if (hasRight) right else SizedBox(width: 50.w),
      ],
    );
  }
}
