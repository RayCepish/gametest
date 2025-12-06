import 'package:game_test/core/constants/app_images.dart';
import 'package:game_test/data/datasources/local_preferences.dart';
import 'package:game_test/data/mappers/profile_mapper.dart';
import 'package:game_test/data/models/profile_model/profile_model.dart';
import 'package:game_test/domain/entities/profile_entity.dart';
import 'package:game_test/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final LocalPreferences _preferences;
  static const String _key = 'player_data';

  ProfileRepositoryImpl(this._preferences);

  @override
  Future<ProfileEntity> getProfile() async {
    final json = _preferences.getJson(_key);

    if (json == null) {
      final defaultPlayer = const ProfileEntity(
        name: 'Guest',
        avatarPath: AppImages.userDefAvatar,
      );
      await updateProfile(defaultPlayer);
      return defaultPlayer;
    }

    return ProfileModel.fromJson(json).toEntity();
  }

  @override
  Future<void> updateProfile(ProfileEntity player) async {
    await _preferences.setJson(_key, player.toModel().toJson());
  }
}
