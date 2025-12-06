import 'package:game_test/domain/entities/profile_entity.dart';
import 'package:game_test/domain/entities/user_entity.dart';

class UserState {
  final UserEntity user;
  final bool loading;
  final String? error;

  const UserState({required this.user, this.loading = false, this.error});

  UserState copyWith({UserEntity? user, bool? loading, String? error}) {
    return UserState(
      user: user ?? this.user,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  factory UserState.initial() => UserState(
    user: UserEntity(
      profile: const ProfileEntity(name: null, email: null, avatarPath: null),
      gold: 1000,
      bestScore: 0,
      eggs: const [],
    ),
  );
}
