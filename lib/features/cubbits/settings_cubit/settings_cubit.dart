import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_test/domain/entities/settings_entity.dart';
import 'package:game_test/domain/usecases/settings_usecases/load_settings_usecase.dart';
import 'package:game_test/domain/usecases/settings_usecases/save_settings_usecase.dart';

import 'package:injectable/injectable.dart';

@singleton
class SettingsCubit extends Cubit<SettingsEntity> {
  final LoadSettingsUseCase loadSettings;
  final SaveSettingsUseCase saveSettings;

  late SettingsEntity _original;
  bool hasUnsavedChanges = false;

  SettingsCubit(this.loadSettings, this.saveSettings)
    : super(const SettingsEntity(sound: true, vibration: true)) {
    _load();
  }

  Future<void> _load() async {
    final loaded = await loadSettings();
    _original = loaded;
    emit(loaded);
  }

  void updateSound(bool value) {
    emit(state.copyWith(sound: value));
    hasUnsavedChanges = true;
  }

  void updateVibration(bool value) {
    emit(state.copyWith(vibration: value));
    hasUnsavedChanges = true;
  }

  Future<void> save() async {
    await saveSettings(state);
    _original = state;
    hasUnsavedChanges = false;
  }

  void revert() {
    emit(_original);
    hasUnsavedChanges = false;
  }
}
