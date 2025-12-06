import 'package:game_test/domain/entities/profile_entity.dart';

class UserEntity {
  final ProfileEntity profile;
  final int gold;
  final int bestScore;
  final List<int> eggs;

  const UserEntity({
    required this.profile,
    required this.gold,
    required this.bestScore,
    required this.eggs,
  });

  UserEntity copyWith({
    ProfileEntity? profile,
    int? gold,
    int? bestScore,
    List<int>? eggs,
  }) {
    return UserEntity(
      profile: profile ?? this.profile,
      gold: gold ?? this.gold,
      bestScore: bestScore ?? this.bestScore,
      eggs: eggs ?? this.eggs,
    );
  }
}
