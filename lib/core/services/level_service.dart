class LevelService {
  static int eggsRequiredForLevel(int level) {
    return level + 2; // level1→3 eggs, level2→4 eggs, level3→5 eggs...
  }

  static bool isLevelUnlocked({required int level, required int eggsCount}) {
    return eggsCount >= eggsRequiredForLevel(level);
  }
}
