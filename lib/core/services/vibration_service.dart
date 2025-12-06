import 'package:injectable/injectable.dart';
import 'package:vibration/vibration.dart';

@singleton
class VibrationService {
  bool enabled = true;

  Future<void> vibrateLight() async {
    if (!enabled) return;
    if (await Vibration.hasVibrator() == true) {
      Vibration.vibrate(duration: 40, amplitude: 50);
    }
  }

  Future<void> vibrateStrong() async {
    if (!enabled) return;
    if (await Vibration.hasVibrator() == true) {
      Vibration.vibrate(duration: 120, amplitude: 180);
    }
  }

  Future<void> toggle(bool value) async {
    enabled = value;
  }
}
