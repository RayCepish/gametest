import 'package:game_test/core/constants/app_sounds.dart';
import 'package:just_audio/just_audio.dart';
import 'package:injectable/injectable.dart';

@singleton
class AudioService {
  final AudioPlayer _player = AudioPlayer();
  String? _currentTrack;
  bool enabled = true;

  String? get currentTrack => _currentTrack;

  Future<void> playMenuMusic() async {
    await playMusic(AppMusic.menu.path);
  }

  Future<void> playGameMusic() async {
    await playMusic(AppMusic.game.path);
  }

  Future<void> playMusic(String asset) async {
    if (!enabled) return;

    if (_currentTrack == asset) return;

    _currentTrack = asset;

    await _player.stop();
    await _player.setAsset(asset);
    await _player.setLoopMode(LoopMode.all);
    await _player.play();
  }

  Future<void> stop() => _player.stop();
}
