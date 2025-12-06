import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_test/data/models/profile_model/profile_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
sealed class UserModel with _$UserModel {
  const factory UserModel({
    required ProfileModel profile,
    required int gold,
    required int bestScore,
    required List<int> eggs,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
