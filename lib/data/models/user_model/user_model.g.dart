// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  profile: ProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
  gold: (json['gold'] as num).toInt(),
  bestScore: (json['bestScore'] as num).toInt(),
  eggs: (json['eggs'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'profile': instance.profile,
      'gold': instance.gold,
      'bestScore': instance.bestScore,
      'eggs': instance.eggs,
    };
