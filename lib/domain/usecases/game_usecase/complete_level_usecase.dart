import 'package:game_test/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompleteLevelUseCase {
  final UserRepository repo;

  CompleteLevelUseCase(this.repo);

  Future<void> call({
    required int level,
    required int correctPresses,
    required int mistakes,
    int? rewardOverride,
  }) async {
    int reward =
        rewardOverride ??
        (correctPresses * (level * 10)) * (mistakes == 0 ? 2 : 1);

    await repo.addGold(reward);

    final best = await repo.getBestScore();
    if (correctPresses > best) {
      await repo.saveBestScore(correctPresses);
    }
  }
}
