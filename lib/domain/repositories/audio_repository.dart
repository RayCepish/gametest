import 'package:game_test/core/constants/app_sounds.dart';

abstract class AudioRepository {
  Future<void> playMusic(AppMusic track);
  Future<void> stopMusic();
  Future<void> toggleMusic(bool enabled, {AppMusic? track});
}
