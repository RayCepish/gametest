import 'package:game_test/data/datasources/local_preferences.dart';
import 'package:game_test/domain/entities/settings_entity.dart';
import 'package:game_test/domain/repositories/settings_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final LocalPreferences preferences;

  SettingsRepositoryImpl(this.preferences);

  @override
  Future<SettingsEntity> load() async {
    return preferences.loadSettings();
  }

  @override
  Future<void> save(SettingsEntity settings) {
    return preferences.saveSettings(settings);
  }
}
