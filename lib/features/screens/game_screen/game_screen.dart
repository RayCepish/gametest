import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_test/core/services/audio_service.dart';
import 'package:game_test/dependency_injection/setup_dependency.dart';
import 'package:game_test/domain/usecases/game_usecase/complete_level_usecase.dart';
import 'package:game_test/features/cubbits/game_cubit/game_cubit.dart';
import 'package:game_test/features/cubbits/user_cubit/user_cubit.dart';
import 'package:game_test/features/screens/game_screen/widgets/game_view.dart';

class GameScreen extends StatelessWidget {
  final int level;

  const GameScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserCubit>().state;
    final eggsForLevel = userState.user.eggs.take(level + 2).toList();

    return BlocProvider(
      create: (_) => GameCubit(
        level: level,
        eggs: eggsForLevel,
        completeLevelUseCase: getIt<CompleteLevelUseCase>(),
        audio: getIt<AudioService>(),
      ),
      child: const GameView(),
    );
  }
}
