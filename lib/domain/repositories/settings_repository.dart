import 'package:game_test/domain/entities/settings_entity.dart';

abstract class SettingsRepository {
  Future<SettingsEntity> load();
  Future<void> save(SettingsEntity settings);
}
