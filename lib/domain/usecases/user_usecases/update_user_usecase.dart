import 'package:game_test/domain/entities/user_entity.dart';
import 'package:game_test/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveUserUseCase {
  final UserRepository repo;
  SaveUserUseCase(this.repo);

  Future<void> call(UserEntity user) => repo.saveUser(user);
}
