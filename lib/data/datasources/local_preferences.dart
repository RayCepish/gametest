import 'dart:convert';

import 'package:game_test/core/constants/app_images.dart';
import 'package:game_test/data/mappers/settings_mapper.dart';
import 'package:game_test/data/mappers/user_mapper.dart';
import 'package:game_test/data/models/settings_model/settings_model.dart';
import 'package:game_test/data/models/user_model/user_model.dart';
import 'package:game_test/domain/entities/profile_entity.dart';
import 'package:game_test/domain/entities/settings_entity.dart';
import 'package:game_test/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class LocalPreferences {
  final SharedPreferences _preferences;
  LocalPreferences(this._preferences);

  Future<void> setJson(String key, Map<String, dynamic> json) async {
    await _preferences.setString(key, jsonEncode(json));
  }

  Map<String, dynamic>? getJson(String key) {
    final str = _preferences.getString(key);
    return str != null ? jsonDecode(str) : null;
  }

  Future<void> saveUser(UserEntity u) async {
    await setJson("user", u.toModel().toJson());
  }

  UserEntity loadUser() {
    final json = getJson("user");
    if (json == null) {
      return UserEntity(
        profile: const ProfileEntity(
          name: "Guest",
          avatarPath: AppImages.userDefAvatar,
        ),
        gold: 1000,
        bestScore: 0,
        eggs: const [0, 1, 2],
      );
    }
    return UserModel.fromJson(json).toEntity();
  }

  Future<void> saveSettings(SettingsEntity s) async {
    await setJson("settings", s.toModel().toJson());
  }

  SettingsEntity loadSettings() {
    final json = getJson("settings");
    if (json == null) {
      return const SettingsEntity(sound: true, vibration: true);
    }
    return SettingsModel.fromJson(json).toEntity();
  }
}
