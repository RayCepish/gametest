import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_test/core/constants/app_images.dart';
import 'package:game_test/core/constants/egg_config.dart';
import 'package:game_test/core/widgets/game_app_bar/game_app_bar.dart';
import 'package:game_test/core/widgets/layouts/main_layout.dart';
import 'package:game_test/features/cubbits/store_cubit/store_cubit.dart';
import 'package:game_test/features/cubbits/store_cubit/store_state.dart';
import 'package:game_test/features/cubbits/user_cubit/user_cubit.dart';
import 'package:game_test/features/screens/store_screen/widgets/egg_store_item.dart';
import 'package:go_router/go_router.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreCubit, StoreState>(
      builder: (context, state) {
        final cubit = context.read<StoreCubit>();
        final user = context.watch<UserCubit>().state.user;

        return MainLayout(
          appBar: GameAppBar(
            leftButtonImage: AppImages.btnBack,
            onLeftTap: () => context.pop(),
            showCoins: true,
          ),
          backgroundImage: AppImages.bgMenu,
          child: Column(
            children: [
              Text(
                "STORE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: eggsList.length,
                  itemBuilder: (_, i) {
                    final egg = eggsList[i];
                    final owned = user.eggs.contains(egg.id);
                    final isAnimating = state.purchasedEggId == egg.id;

                    return EggStoreItem(
                      key: ValueKey(egg.id),
                      egg: egg,
                      owned: owned,
                      isAnimating: isAnimating,
                      onTap: owned
                          ? null
                          : () => cubit.purchase(egg.id, egg.price),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
