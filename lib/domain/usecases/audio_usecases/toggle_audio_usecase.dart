import 'package:game_test/core/constants/app_sounds.dart';
import 'package:game_test/domain/repositories/audio_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ToggleAudioUseCase {
  final AudioRepository repo;

  ToggleAudioUseCase(this.repo);

  Future<void> call(bool enabled, {AppMusic? track}) {
    return repo.toggleMusic(enabled, track: track);
  }
}
