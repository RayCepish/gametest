class LeaderboardEntity {
  final String name;
  final String? avatarPath;
  final int bestScore;

  const LeaderboardEntity({
    required this.name,
    this.avatarPath,
    required this.bestScore,
  });
}
