import 'package:game_test/domain/entities/profile_entity.dart';
import 'package:game_test/domain/entities/user_entity.dart';

final others = <UserEntity>[
  UserEntity(
    profile: const ProfileEntity(
      name: "ProChicken",
      email: "pro@game.com",
      avatarPath: null,
    ),
    gold: 2500,
    bestScore: 9000,
    eggs: const [1, 2, 3, 4],
  ),
  UserEntity(
    profile: const ProfileEntity(
      name: "EggMaster",
      email: "egg@master.com",
      avatarPath: null,
    ),
    gold: 1700,
    bestScore: 7200,
    eggs: const [1, 2],
  ),
  UserEntity(
    profile: const ProfileEntity(
      name: "ChickNoob",
      email: "noob@game.com",
      avatarPath: null,
    ),
    gold: 300,
    bestScore: 1200,
    eggs: const [1],
  ),
];
