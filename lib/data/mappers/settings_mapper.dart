import 'package:game_test/data/models/settings_model/settings_model.dart';
import 'package:game_test/domain/entities/settings_entity.dart';

extension SettingsModelMapper on SettingsModel {
  SettingsEntity toEntity() =>
      SettingsEntity(sound: sound, vibration: vibration);
}

extension SettingsEntityMapper on SettingsEntity {
  SettingsModel toModel() => SettingsModel(sound: sound, vibration: vibration);
}
