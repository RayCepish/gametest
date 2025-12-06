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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leftButtonImage != null
            ? AppBarButton(image: leftButtonImage!, onTap: onLeftTap)
            : SizedBox(width: 50.w),

        const Spacer(),
        Row(
          children: [
            if (showCoins)
              GestureDetector(
                onTap: onCoinsTap,
                child: CoinsDisplay(value: gold),
              ),

            SizedBox(width: 10.w),

            if (rightButtonImage != null)
              AppBarButton(image: rightButtonImage!, onTap: onRightTap),
          ],
        ),
      ],
    );
  }
}
