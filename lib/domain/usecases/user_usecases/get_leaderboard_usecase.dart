import 'package:game_test/domain/entities/user_entity.dart';
import 'package:game_test/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetLeaderboardUseCase {
  final UserRepository repository;

  GetLeaderboardUseCase(this.repository);

  Future<List<UserEntity>> call(UserEntity current) =>
      repository.getLeaderboard(current);
}
