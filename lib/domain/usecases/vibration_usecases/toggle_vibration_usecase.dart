import 'package:game_test/domain/repositories/vibration_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ToggleVibrationUseCase {
  final VibrationRepository repo;

  ToggleVibrationUseCase(this.repo);

  Future<void> call(bool enabled) => repo.toggle(enabled);
}
