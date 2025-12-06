import 'package:game_test/domain/entities/user_entity.dart';
import 'package:game_test/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

class BuyEggParams {
  final UserEntity current;
  final int eggId;
  final int price;

  BuyEggParams({
    required this.current,
    required this.eggId,
    required this.price,
  });
}

@injectable
class BuyEggUseCase {
  final UserRepository repo;

  BuyEggUseCase(this.repo);

  Future<UserEntity> call(BuyEggParams params) async {
    return repo.buyEgg(
      current: params.current,
      eggId: params.eggId,
      price: params.price,
    );
  }
}
