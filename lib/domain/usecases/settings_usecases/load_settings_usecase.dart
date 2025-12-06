import 'package:game_test/domain/entities/settings_entity.dart';
import 'package:game_test/domain/repositories/settings_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoadSettingsUseCase {
  final SettingsRepository repo;

  LoadSettingsUseCase(this.repo);

  Future<SettingsEntity> call() => repo.load();
}
