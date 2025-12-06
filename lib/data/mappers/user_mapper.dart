import 'package:game_test/data/mappers/profile_mapper.dart';
import 'package:game_test/data/models/user_model/user_model.dart';
import 'package:game_test/domain/entities/user_entity.dart';

extension UserModelMapper on UserModel {
  UserEntity toEntity() => UserEntity(
    profile: profile.toEntity(),
    gold: gold,
    bestScore: bestScore,
    eggs: eggs,
  );
}

extension UserEntityMapper on UserEntity {
  UserModel toModel() => UserModel(
    profile: profile.toModel(),
    gold: gold,
    bestScore: bestScore,
    eggs: eggs,
  );
}
