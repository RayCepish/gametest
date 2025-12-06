import 'package:game_test/domain/repositories/vibration_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class VibrateUseCase {
  final VibrationRepository repo;

  VibrateUseCase(this.repo);

  Future<void> call() => repo.vibrate();
}
