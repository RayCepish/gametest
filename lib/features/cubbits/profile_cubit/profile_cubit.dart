import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_test/domain/entities/profile_entity.dart';
import 'package:game_test/domain/usecases/profile_usecases/get_profile_usecase.dart';
import 'package:game_test/domain/usecases/profile_usecases/save_profile_usecase.dart';
import 'package:game_test/features/cubbits/profile_cubit/profile_state.dart';
import 'package:injectable/injectable.dart';

@singleton
class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfile;
  final SaveProfileUseCase saveProfile;

  late ProfileEntity _original;
  bool hasUnsavedChanges = false;

  ProfileCubit(this.getProfile, this.saveProfile)
    : super(
        ProfileState(const ProfileEntity(name: '', email: '', avatarPath: '')),
      ) {
    _load();
  }

  Future<void> _load() async {
    final loaded = await getProfile();
    _original = loaded;
    emit(ProfileState(loaded));
  }

  void updateName(String value) {
    emit(state.copyWith(profile: state.profile.copyWith(name: value)));
    hasUnsavedChanges = true;
  }

  void updateEmail(String value) {
    emit(state.copyWith(profile: state.profile.copyWith(email: value)));
    hasUnsavedChanges = true;
  }

  void updateAvatar(String path) {
    emit(state.copyWith(profile: state.profile.copyWith(avatarPath: path)));
    hasUnsavedChanges = true;
  }

  Future<void> save() async {
    await saveProfile(state.profile);
    _original = state.profile;
    hasUnsavedChanges = false;
  }

  void revert() {
    emit(ProfileState(_original));
    hasUnsavedChanges = false;
  }
}
