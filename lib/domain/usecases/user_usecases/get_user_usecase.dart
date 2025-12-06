import 'package:game_test/domain/entities/user_entity.dart';
import 'package:game_test/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserUseCase {
  final UserRepository repository;

  GetUserUseCase(this.repository);

  Future<UserEntity> call() => repository.getUser();
}
