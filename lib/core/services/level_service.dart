class LevelService {
  static int eggsRequiredForLevel(int level) {
    return level + 2;
  }

  static bool isLevelUnlocked({required int level, required int eggsCount}) {
    final unlockedLevels = (eggsCount - 2).clamp(1, 10);
    return level <= unlockedLevels;
  }
}
