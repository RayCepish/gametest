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
}
