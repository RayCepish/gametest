abstract class VibrationRepository {
  Future<void> vibrate();
  Future<void> toggle(bool enabled);
}
