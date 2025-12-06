import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_test/core/constants/app_sounds.dart';
import 'package:game_test/core/services/audio_service.dart';
import 'package:game_test/data/datasources/local_preferences.dart';
import 'package:game_test/dependency_injection/setup_dependency.dart';
import 'package:game_test/features/cubbits/user_cubit/user_cubit.dart';
import 'package:injectable/injectable.dart';

import 'game_state.dart';
import 'package:game_test/domain/usecases/game_usecase/complete_level_usecase.dart';

@injectable
class GameCubit extends Cubit<GameState> {
  static const int maxMistakes = 3;
  static const int sequencesPerLevel = 3;

  final CompleteLevelUseCase completeLevelUseCase;
  final AudioService audio;
  final Random _rng = Random();

  bool _isCancelled = false;

  GameCubit({
    required int level,
    required List<int> eggs,
    required this.completeLevelUseCase,
    required this.audio,
  }) : super(GameState.initial(level: level, eggs: eggs)) {
    final settings = getIt<LocalPreferences>().loadSettings();

    if (settings.sound) {
      unawaited(audio.playMusic(AppMusic.game.path));
    }

    startCountdown();
  }

  // ------------------------------------------------------------
  // SAFE EMIT
  // ------------------------------------------------------------
  void safeEmit(GameState newState) {
    if (!_isCancelled && !isClosed) emit(newState);
  }

  // ------------------------------------------------------------
  // CLEANUP
  // ------------------------------------------------------------
  @override
  Future<void> close() async {
    _isCancelled = true;
    final settings = getIt<LocalPreferences>().loadSettings();

    if (settings.sound) {
      await audio.playMusic(AppMusic.menu.path);
    }
    return super.close();
  }

  // ------------------------------------------------------------
  // UTILS
  // ------------------------------------------------------------
  Future<void> _shortCoolDown() async {
    await Future.delayed(const Duration(milliseconds: 900));
    if (_isCancelled) return;
  }

  // ------------------------------------------------------------
  // INITIAL COUNTDOWN
  // ------------------------------------------------------------
  Future<void> startCountdown() async {
    safeEmit(state.copyWith(phase: GamePhase.countdown, countdown: 3));

    for (int i = 3; i > 0; i--) {
      if (_isCancelled) return;
      safeEmit(state.copyWith(countdown: i));
      await Future.delayed(const Duration(seconds: 1));
    }

    if (_isCancelled) return;
    await _startNewSequence();
  }

  // ------------------------------------------------------------
  // REPEAT COUNTDOWN
  // ------------------------------------------------------------
  Future<void> _startRepeatCountdown() async {
    safeEmit(state.copyWith(phase: GamePhase.countdown, countdown: 2));

    for (int i = 2; i > 0; i--) {
      if (_isCancelled) return;
      safeEmit(state.copyWith(countdown: i));
      await Future.delayed(const Duration(milliseconds: 700));
    }
  }

  // ------------------------------------------------------------
  // RANDOM SEQUENCE GENERATOR
  // ------------------------------------------------------------
  List<int> _generateSequence() {
    return List.generate(
      state.eggs.length,
      (_) => state.eggs[_rng.nextInt(state.eggs.length)],
    );
  }

  // ------------------------------------------------------------
  // NEW SEQUENCE
  // ------------------------------------------------------------
  Future<void> _startNewSequence() async {
    final seq = _generateSequence();

    safeEmit(
      state.copyWith(
        currentSequence: seq,
        sequenceStep: 0,
        phase: GamePhase.showingSequence,
      ),
    );

    await _showSequence(seq);

    if (_isCancelled) return;

    safeEmit(
      state.copyWith(phase: GamePhase.waitingForPlayer, sequenceStep: 0),
    );
  }

  // ------------------------------------------------------------
  // SHOW SEQUENCE
  // ------------------------------------------------------------
  Future<void> _showSequence(List<int> seq) async {
    for (final eggId in seq) {
      if (_isCancelled) return;
      if (state.overlay != GameOverlayType.none) return;

      safeEmit(
        state.copyWith(
          eggStates: {...state.eggStates, eggId: EggHighlightState.highlight},
        ),
      );

      await Future.delayed(const Duration(milliseconds: 450));
      if (_isCancelled) return;

      safeEmit(
        state.copyWith(
          eggStates: {...state.eggStates, eggId: EggHighlightState.none},
        ),
      );

      await Future.delayed(const Duration(milliseconds: 180));
      if (_isCancelled) return;
    }
  }

  // ------------------------------------------------------------
  // PLAYER TAP
  // ------------------------------------------------------------
  Future<void> onPlayerTapEgg(int eggId) async {
    if (!state.isInputEnabled || _isCancelled) return;

    final expected = state.currentSequence[state.sequenceStep];

    if (eggId == expected) {
      await _handleCorrectPress(eggId);
    } else {
      await _handleMistake(eggId);
    }
  }

  // ------------------------------------------------------------
  // CORRECT PRESS
  // ------------------------------------------------------------
  Future<void> _handleCorrectPress(int eggId) async {
    // 💰 Award for each correct tap
    getIt<UserCubit>().addGold(100);

    safeEmit(
      state.copyWith(
        phase: GamePhase.showingSequence,
        eggStates: {...state.eggStates, eggId: EggHighlightState.correct},
      ),
    );

    await Future.delayed(const Duration(milliseconds: 230));
    if (_isCancelled) return;

    safeEmit(
      state.copyWith(
        eggStates: {...state.eggStates, eggId: EggHighlightState.none},
      ),
    );

    final reward = state.level * 10;
    final newScore = state.score + reward;
    final newStep = state.sequenceStep + 1;

    if (newStep < state.currentSequence.length) {
      safeEmit(
        state.copyWith(
          score: newScore,
          sequenceStep: newStep,
          phase: GamePhase.waitingForPlayer,
        ),
      );
      return;
    }

    // END OF SEQUENCE
    safeEmit(
      state.copyWith(
        score: newScore,
        sequenceStep: newStep,
        phase: GamePhase.showingSequence,
      ),
    );

    if (state.isLastSequence) {
      await _completeLevel();
      return;
    }

    await _shortCoolDown();
    if (_isCancelled) return;

    safeEmit(
      state.copyWith(sequenceNumber: state.sequenceNumber + 1, sequenceStep: 0),
    );

    await _startNewSequence();
  }

  // ------------------------------------------------------------
  // WRONG PRESS
  // ------------------------------------------------------------
  Future<void> _handleMistake(int eggId) async {
    final mistakes = state.mistakes + 1;

    safeEmit(
      state.copyWith(
        phase: GamePhase.showingSequence,
        eggStates: {...state.eggStates, eggId: EggHighlightState.wrong},
      ),
    );

    await Future.delayed(const Duration(milliseconds: 500));
    if (_isCancelled) return;

    safeEmit(
      state.copyWith(
        eggStates: {...state.eggStates, eggId: EggHighlightState.none},
      ),
    );

    if (mistakes >= maxMistakes) {
      safeEmit(
        state.copyWith(mistakes: mistakes, overlay: GameOverlayType.lose),
      );
      return;
    }

    safeEmit(
      state.copyWith(
        mistakes: mistakes,
        phase: GamePhase.showingSequence,
        sequenceStep: 0,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 400));
    if (_isCancelled) return;

    await _startRepeatCountdown();
    await _repeatSequence();
    await _shortCoolDown();

    if (_isCancelled) return;

    safeEmit(
      state.copyWith(phase: GamePhase.waitingForPlayer, sequenceStep: 0),
    );
  }

  Future<void> _repeatSequence() async {
    safeEmit(state.copyWith(phase: GamePhase.showingSequence, sequenceStep: 0));
    await _showSequence(state.currentSequence);
  }

  // ------------------------------------------------------------
  // COMPLETE LEVEL
  // ------------------------------------------------------------
  Future<void> _completeLevel() async {
    if (_isCancelled) return;

    int reward = state.score;

    if (state.mistakes == 0) {
      reward *= 2;
    }

    // 💰 Award total level reward
    getIt<UserCubit>().addGold(reward);

    // 🏆 Best score update
    final userCubit = getIt<UserCubit>();
    if (state.score > userCubit.state.user.bestScore) {
      userCubit.setBestScore(state.score);
    }

    await completeLevelUseCase(
      level: state.level,
      correctPresses: state.currentSequence.length * sequencesPerLevel,
      mistakes: state.mistakes,
      rewardOverride: reward,
    );

    if (_isCancelled) return;

    safeEmit(state.copyWith(overlay: GameOverlayType.win));
  }

  // ------------------------------------------------------------
  // PAUSE / RESUME
  // ------------------------------------------------------------
  void pause() {
    if (state.overlay == GameOverlayType.none) {
      safeEmit(state.copyWith(overlay: GameOverlayType.paused));
    }
  }

  void resume() {
    if (state.overlay != GameOverlayType.paused) return;

    final shouldReplay = state.phase == GamePhase.waitingForPlayer;

    safeEmit(state.copyWith(overlay: GameOverlayType.none));

    if (shouldReplay) {
      _resumeWithReplay();
    }
  }

  Future<void> _resumeWithReplay() async {
    safeEmit(state.copyWith(phase: GamePhase.showingSequence, sequenceStep: 0));

    await _startRepeatCountdown();
    await _repeatSequence();
    await _shortCoolDown();

    if (_isCancelled) return;

    safeEmit(
      state.copyWith(phase: GamePhase.waitingForPlayer, sequenceStep: 0),
    );
  }

  Future<void> restart() async {
    safeEmit(GameState.initial(level: state.level, eggs: state.eggs));
    await startCountdown();
  }
}
