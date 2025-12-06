import 'package:game_test/data/models/profile_model/profile_model.dart';
import 'package:game_test/domain/entities/profile_entity.dart';

extension ProfileEntityMapper on ProfileEntity {
  ProfileModel toModel() =>
      ProfileModel(name: name, email: email, avatarPath: avatarPath);
}

extension ProfileModelMapper on ProfileModel {
  ProfileEntity toEntity() => ProfileEntity(
    name: name ?? '',
    email: email ?? '',
    avatarPath: avatarPath ?? '',
  );
}
