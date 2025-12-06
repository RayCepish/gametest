import 'package:game_test/domain/repositories/audio_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class StopAudioUseCase {
  final AudioRepository repo;

  StopAudioUseCase(this.repo);

  Future<void> call() {
    return repo.stopMusic();
  }
}
