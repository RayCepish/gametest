enum GamePhase { countdown, repeatCountdown, showingSequence, waitingForPlayer }

enum GameOverlayType { none, paused, win, lose }

enum EggHighlightState { none, highlight, correct, wrong }

class GameState {
  final int level;
  final List<int> eggs;
  final List<int> currentSequence;
  final int sequenceStep;
  final int sequenceNumber;
  final int mistakes;
  final int score;

  final Map<int, EggHighlightState> eggStates;

  final GamePhase phase;
  final int countdown;
  final GameOverlayType overlay;

  bool get isInputEnabled =>
      phase == GamePhase.waitingForPlayer && overlay == GameOverlayType.none;

  bool get isLastSequence => sequenceNumber >= 3;

  double get sequenceProgress {
    if (currentSequence.isEmpty) return 0;
    final v = sequenceStep / currentSequence.length;
    if (v < 0) return 0;
    if (v > 1) return 1;
    return v;
  }

  const GameState({
    required this.level,
    required this.eggs,
    required this.currentSequence,
    required this.sequenceStep,
    required this.sequenceNumber,
    required this.mistakes,
    required this.score,
    required this.eggStates,
    required this.phase,
    required this.countdown,
    required this.overlay,
  });

  factory GameState.initial({required int level, required List<int> eggs}) {
    return GameState(
      level: level,
      eggs: eggs,
      currentSequence: const [],
      sequenceStep: 0,
      sequenceNumber: 1,
      mistakes: 0,
      score: 0,
      eggStates: {for (final id in eggs) id: EggHighlightState.none},
      phase: GamePhase.countdown,
      countdown: 3,
      overlay: GameOverlayType.none,
    );
  }

  GameState copyWith({
    List<int>? currentSequence,
    int? sequenceStep,
    int? sequenceNumber,
    int? mistakes,
    int? score,
    Map<int, EggHighlightState>? eggStates,
    GamePhase? phase,
    int? countdown,
    GameOverlayType? overlay,
  }) {
    return GameState(
      level: level,
      eggs: eggs,
      currentSequence: currentSequence ?? this.currentSequence,
      sequenceStep: sequenceStep ?? this.sequenceStep,
      sequenceNumber: sequenceNumber ?? this.sequenceNumber,
      mistakes: mistakes ?? this.mistakes,
      score: score ?? this.score,
      eggStates: eggStates ?? this.eggStates,
      phase: phase ?? this.phase,
      countdown: countdown ?? this.countdown,
      overlay: overlay ?? this.overlay,
    );
  }
}
