import 'package:game_test/domain/entities/profile_entity.dart';
import 'package:game_test/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveProfileUseCase {
  final ProfileRepository repository;
  SaveProfileUseCase(this.repository);

  Future<void> call(ProfileEntity profile) => repository.updateProfile(profile);
}
