import 'package:game_test/domain/entities/profile_entity.dart';

class ProfileState {
  final ProfileEntity profile;

  const ProfileState(this.profile);

  ProfileState copyWith({ProfileEntity? profile}) =>
      ProfileState(profile ?? this.profile);
}
