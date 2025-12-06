import 'package:game_test/domain/entities/profile_entity.dart';
import 'package:game_test/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<ProfileEntity> call() => repository.getProfile();
}
