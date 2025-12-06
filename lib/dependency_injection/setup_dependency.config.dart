// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:game_test/core/services/audio_service.dart' as _i1019;
import 'package:game_test/core/services/vibration_service.dart' as _i881;
import 'package:game_test/data/datasources/local_preferences.dart' as _i225;
import 'package:game_test/data/repository_impl/audio_repository_impl.dart'
    as _i808;
import 'package:game_test/data/repository_impl/profile_repository_impl.dart'
    as _i964;
import 'package:game_test/data/repository_impl/settings_repository_impl.dart'
    as _i450;
import 'package:game_test/data/repository_impl/user_repository_impl.dart'
    as _i303;
import 'package:game_test/data/repository_impl/vibration_repository_impl.dart'
    as _i616;
import 'package:game_test/dependency_injection/register_module.dart' as _i623;
import 'package:game_test/domain/repositories/audio_repository.dart' as _i180;
import 'package:game_test/domain/repositories/profile_repository.dart' as _i242;
import 'package:game_test/domain/repositories/settings_repository.dart'
    as _i801;
import 'package:game_test/domain/repositories/user_repository.dart' as _i900;
import 'package:game_test/domain/repositories/vibration_repository.dart'
    as _i1017;
import 'package:game_test/domain/usecases/audio_usecases/play_audio_usecase.dart'
    as _i30;
import 'package:game_test/domain/usecases/audio_usecases/stop_audio_usecase.dart'
    as _i464;
import 'package:game_test/domain/usecases/audio_usecases/toggle_audio_usecase.dart'
    as _i218;
import 'package:game_test/domain/usecases/game_usecase/complete_level_usecase.dart'
    as _i270;
import 'package:game_test/domain/usecases/profile_usecases/get_profile_usecase.dart'
    as _i493;
import 'package:game_test/domain/usecases/profile_usecases/save_profile_usecase.dart'
    as _i439;
import 'package:game_test/domain/usecases/settings_usecases/load_settings_usecase.dart'
    as _i559;
import 'package:game_test/domain/usecases/settings_usecases/save_settings_usecase.dart'
    as _i355;
import 'package:game_test/domain/usecases/user_usecases/bue_egg_usecase.dart'
    as _i238;
import 'package:game_test/domain/usecases/user_usecases/get_leaderboard_usecase.dart'
    as _i441;
import 'package:game_test/domain/usecases/user_usecases/get_user_usecase.dart'
    as _i804;
import 'package:game_test/domain/usecases/user_usecases/save_user_repository.dart'
    as _i121;
import 'package:game_test/domain/usecases/user_usecases/update_user_usecase.dart'
    as _i35;
import 'package:game_test/domain/usecases/vibration_usecases/toggle_vibration_usecase.dart'
    as _i987;
import 'package:game_test/domain/usecases/vibration_usecases/vibrate_usecase.dart'
    as _i694;
import 'package:game_test/features/cubbits/app_lifecycle_cubit/app_lifecycle_cubit.dart'
    as _i404;
import 'package:game_test/features/cubbits/game_cubit/game_cubit.dart' as _i299;
import 'package:game_test/features/cubbits/leaderboard_cubit/leaderboard_cubit.dart'
    as _i892;
import 'package:game_test/features/cubbits/profile_cubit/profile_cubit.dart'
    as _i363;
import 'package:game_test/features/cubbits/settings_cubit/settings_cubit.dart'
    as _i792;
import 'package:game_test/features/cubbits/store_cubit/store_cubit.dart'
    as _i949;
import 'package:game_test/features/cubbits/user_cubit/user_cubit.dart' as _i975;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.preference,
      preResolve: true,
    );
    gh.singleton<_i1019.AudioService>(() => _i1019.AudioService());
    gh.singleton<_i881.VibrationService>(() => _i881.VibrationService());
    gh.singleton<_i404.AppLifecycleCubit>(() => _i404.AppLifecycleCubit());
    gh.lazySingleton<_i180.AudioRepository>(
      () => _i808.AudioRepositoryImpl(gh<_i1019.AudioService>()),
    );
    gh.lazySingleton<_i1017.VibrationRepository>(
      () => _i616.VibrationRepositoryImpl(gh<_i881.VibrationService>()),
    );
    gh.singleton<_i225.LocalPreferences>(
      () => _i225.LocalPreferences(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i801.SettingsRepository>(
      () => _i450.SettingsRepositoryImpl(gh<_i225.LocalPreferences>()),
    );
    gh.factory<_i30.PlayAudioUseCase>(
      () => _i30.PlayAudioUseCase(gh<_i180.AudioRepository>()),
    );
    gh.factory<_i464.StopAudioUseCase>(
      () => _i464.StopAudioUseCase(gh<_i180.AudioRepository>()),
    );
    gh.factory<_i218.ToggleAudioUseCase>(
      () => _i218.ToggleAudioUseCase(gh<_i180.AudioRepository>()),
    );
    gh.factory<_i987.ToggleVibrationUseCase>(
      () => _i987.ToggleVibrationUseCase(gh<_i1017.VibrationRepository>()),
    );
    gh.factory<_i694.VibrateUseCase>(
      () => _i694.VibrateUseCase(gh<_i1017.VibrationRepository>()),
    );
    gh.lazySingleton<_i900.UserRepository>(
      () => _i303.UserRepositoryImpl(gh<_i225.LocalPreferences>()),
    );
    gh.lazySingleton<_i242.ProfileRepository>(
      () => _i964.ProfileRepositoryImpl(gh<_i225.LocalPreferences>()),
    );
    gh.factory<_i559.LoadSettingsUseCase>(
      () => _i559.LoadSettingsUseCase(gh<_i801.SettingsRepository>()),
    );
    gh.factory<_i355.SaveSettingsUseCase>(
      () => _i355.SaveSettingsUseCase(gh<_i801.SettingsRepository>()),
    );
    gh.factory<_i441.GetLeaderboardUseCase>(
      () => _i441.GetLeaderboardUseCase(gh<_i900.UserRepository>()),
    );
    gh.factory<_i804.GetUserUseCase>(
      () => _i804.GetUserUseCase(gh<_i900.UserRepository>()),
    );
    gh.factory<_i121.SaveUserUseCase>(
      () => _i121.SaveUserUseCase(gh<_i900.UserRepository>()),
    );
    gh.factory<_i493.GetProfileUseCase>(
      () => _i493.GetProfileUseCase(gh<_i242.ProfileRepository>()),
    );
    gh.factory<_i439.SaveProfileUseCase>(
      () => _i439.SaveProfileUseCase(gh<_i242.ProfileRepository>()),
    );
    gh.factory<_i270.CompleteLevelUseCase>(
      () => _i270.CompleteLevelUseCase(gh<_i900.UserRepository>()),
    );
    gh.factory<_i238.BuyEggUseCase>(
      () => _i238.BuyEggUseCase(gh<_i900.UserRepository>()),
    );
    gh.factory<_i35.SaveUserUseCase>(
      () => _i35.SaveUserUseCase(gh<_i900.UserRepository>()),
    );
    gh.factory<_i892.LeaderboardCubit>(
      () => _i892.LeaderboardCubit(gh<_i900.UserRepository>()),
    );
    gh.singleton<_i792.SettingsCubit>(
      () => _i792.SettingsCubit(
        gh<_i559.LoadSettingsUseCase>(),
        gh<_i355.SaveSettingsUseCase>(),
      ),
    );
    gh.factory<_i299.GameCubit>(
      () => _i299.GameCubit(
        level: gh<int>(),
        eggs: gh<List<int>>(),
        completeLevelUseCase: gh<_i270.CompleteLevelUseCase>(),
        audio: gh<_i1019.AudioService>(),
      ),
    );
    gh.singleton<_i363.ProfileCubit>(
      () => _i363.ProfileCubit(
        gh<_i493.GetProfileUseCase>(),
        gh<_i439.SaveProfileUseCase>(),
      ),
    );
    gh.singleton<_i975.UserCubit>(
      () => _i975.UserCubit(
        gh<_i804.GetUserUseCase>(),
        gh<_i35.SaveUserUseCase>(),
        gh<_i238.BuyEggUseCase>(),
      ),
    );
    gh.singleton<_i949.StoreCubit>(
      () => _i949.StoreCubit(gh<_i975.UserCubit>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i623.RegisterModule {}
