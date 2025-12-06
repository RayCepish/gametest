import 'package:game_test/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUser();

  Future<void> saveUser(UserEntity user);

  Future<UserEntity> buyEgg({
    required UserEntity current,
    required int eggId,
    required int price,
  });

  Future<void> addGold(int amount);

  Future<int> getBestScore();
  Future<void> saveBestScore(int score);

  Future<List<UserEntity>> getLeaderboard(UserEntity current);
}
