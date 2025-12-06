import 'package:game_test/domain/entities/settings_entity.dart';
import 'package:game_test/domain/repositories/settings_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveSettingsUseCase {
  final SettingsRepository repo;

  SaveSettingsUseCase(this.repo);

  Future<void> call(SettingsEntity entity) => repo.save(entity);
}
