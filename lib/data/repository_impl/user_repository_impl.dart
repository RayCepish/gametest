import 'package:game_test/core/constants/mock_users.dart';
import 'package:game_test/data/datasources/local_preferences.dart';
import 'package:game_test/domain/entities/user_entity.dart';
import 'package:game_test/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final LocalPreferences preferences;

  UserRepositoryImpl(this.preferences);

  @override
  Future<UserEntity> getUser() async {
    return preferences.loadUser();
  }

  @override
  Future<void> saveUser(UserEntity user) async {
    await preferences.saveUser(user);
  }

  @override
  Future<UserEntity> buyEgg({
    required UserEntity current,
    required int eggId,
    required int price,
  }) async {
    if (current.gold < price) return current;

    final updated = current.copyWith(
      gold: current.gold - price,
      eggs: [...current.eggs, eggId],
    );

    await saveUser(updated);
    return updated;
  }

  @override
  Future<void> addGold(int amount) async {
    final user = await getUser();
    final updated = user.copyWith(gold: user.gold + amount);
    await saveUser(updated);
  }

  @override
  Future<int> getBestScore() async {
    final user = await getUser();
    return user.bestScore;
  }

  @override
  Future<void> saveBestScore(int score) async {
    final user = await getUser();
    if (score <= user.bestScore) return;

    final updated = user.copyWith(bestScore: score);
    await saveUser(updated);
  }

  @override
  Future<List<UserEntity>> getLeaderboard(UserEntity current) async {
    final all = [current, ...others];
    all.sort((a, b) => b.bestScore.compareTo(a.bestScore));
    return all;
  }
}
