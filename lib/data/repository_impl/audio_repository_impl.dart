import 'package:game_test/core/constants/app_sounds.dart';
import 'package:game_test/core/services/audio_service.dart';
import 'package:game_test/domain/repositories/audio_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AudioRepository)
class AudioRepositoryImpl implements AudioRepository {
  final AudioService service;

  AudioRepositoryImpl(this.service);

  @override
  Future<void> playMusic(AppMusic track) {
    return service.playMusic(track.path);
  }

  @override
  Future<void> stopMusic() {
    return service.stop();
  }

  @override
  Future<void> toggleMusic(bool enabled, {AppMusic? track}) async {
    service.enabled = enabled;

    if (!enabled) {
      await service.stop();
      return;
    }

    if (track != null) {
      await service.playMusic(track.path);
      return;
    }

    if (service.currentTrack != null) {
      await service.playMusic(service.currentTrack!);
      return;
    }

    await service.playMenuMusic();
  }
}
