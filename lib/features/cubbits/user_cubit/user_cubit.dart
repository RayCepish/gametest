import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:game_test/domain/usecases/user_usecases/bue_egg_usecase.dart';
import 'package:game_test/domain/usecases/user_usecases/get_user_usecase.dart';
import 'package:game_test/domain/usecases/user_usecases/update_user_usecase.dart';
import 'package:game_test/features/cubbits/user_cubit/user_state.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserCubit extends Cubit<UserState> {
  final GetUserUseCase _getUser;
  final SaveUserUseCase _saveUser;
  final BuyEggUseCase _buyEgg;

  UserCubit(this._getUser, this._saveUser, this._buyEgg)
    : super(UserState.initial());

  Future<void> init() async {
    emit(state.copyWith(loading: true));

    final user = await _getUser();

    emit(UserState(user: user, loading: false));
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    String? avatarPath,
  }) async {
    final updated = state.user.copyWith(
      profile: state.user.profile.copyWith(
        name: name ?? state.user.profile.name,
        email: email ?? state.user.profile.email,
        avatarPath: avatarPath ?? state.user.profile.avatarPath,
      ),
    );

    emit(state.copyWith(user: updated));
    await _saveUser(updated);
  }

  Future<void> buyEgg(int eggId, int price) async {
    final updated = await _buyEgg(
      BuyEggParams(current: state.user, eggId: eggId, price: price),
    );

    emit(state.copyWith(user: updated));
  }

  Future<void> setBestScore(int score) async {
    if (score <= state.user.bestScore) return;

    final updated = state.user.copyWith(bestScore: score);
    emit(state.copyWith(user: updated));

    await _saveUser(updated);
  }

  Future<void> addGold(int delta) async {
    final updated = state.user.copyWith(gold: state.user.gold + delta);

    emit(state.copyWith(user: updated));

    await _saveUser(updated);
  }
}
