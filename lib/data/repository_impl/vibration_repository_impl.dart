import 'package:game_test/core/services/vibration_service.dart';
import 'package:game_test/domain/repositories/vibration_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: VibrationRepository)
class VibrationRepositoryImpl implements VibrationRepository {
  final VibrationService service;

  VibrationRepositoryImpl(this.service);

  @override
  Future<void> vibrate() => service.vibrateLight();

  @override
  Future<void> toggle(bool enabled) => service.toggle(enabled);
}
