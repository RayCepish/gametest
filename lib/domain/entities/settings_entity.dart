class SettingsEntity {
  final bool sound;
  final bool vibration;

  const SettingsEntity({required this.sound, required this.vibration});

  SettingsEntity copyWith({bool? sound, bool? vibration}) {
    return SettingsEntity(
      sound: sound ?? this.sound,
      vibration: vibration ?? this.vibration,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingsEntity &&
        other.sound == sound &&
        other.vibration == vibration;
  }

  @override
  int get hashCode => Object.hash(sound, vibration);
}
