class ProfileEntity {
  final String? name;
  final String? email;
  final String? avatarPath;

  const ProfileEntity({required this.name, this.email, this.avatarPath});

  ProfileEntity copyWith({String? name, String? email, String? avatarPath}) {
    return ProfileEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      avatarPath: avatarPath ?? this.avatarPath,
    );
  }
}
