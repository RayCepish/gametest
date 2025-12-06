import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_test/core/services/audio_service.dart';
import 'package:game_test/core/services/vibration_service.dart';
import 'package:game_test/domain/entities/settings_entity.dart';
import 'package:game_test/domain/usecases/settings_usecases/load_settings_usecase.dart';
import 'package:game_test/domain/usecases/settings_usecases/save_settings_usecase.dart';

import 'package:injectable/injectable.dart';

@singleton
class SettingsCubit extends Cubit<SettingsEntity> {
  final LoadSettingsUseCase loadSettings;
  final SaveSettingsUseCase saveSettings;

  final AudioService audio;
  final VibrationService vibration;

  late SettingsEntity _original;

  SettingsCubit(
    this.loadSettings,
    this.saveSettings,
    this.audio,
    this.vibration,
  ) : super(const SettingsEntity(sound: true, vibration: true)) {
    _load();
  }

  bool get hasUnsavedChanges => state != _original;

  Future<void> _load() async {
    final loaded = await loadSettings();
    _original = loaded;
    emit(loaded);
  }

  void updateSound(bool value) {
    emit(state.copyWith(sound: value));

    audio.enabled = value;

    if (value) {
      audio.playMenuMusic();
    } else {
      audio.stop();
    }
  }

  void updateVibration(bool value) {
    emit(state.copyWith(vibration: value));

    vibration.enabled = value;
    if (value) vibration.vibrateLight();
  }

  Future<void> save() async {
    await saveSettings(state);
    _original = state;
  }

  void revert() {
    emit(_original);
  }
}
