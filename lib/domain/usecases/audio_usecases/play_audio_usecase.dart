import 'package:game_test/core/constants/app_sounds.dart';
import 'package:game_test/domain/repositories/audio_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class PlayAudioUseCase {
  final AudioRepository repo;

  PlayAudioUseCase(this.repo);

  Future<void> call(AppMusic track) {
    return repo.playMusic(track);
  }
}
