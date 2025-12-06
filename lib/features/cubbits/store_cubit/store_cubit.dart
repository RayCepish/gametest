import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_test/features/cubbits/user_cubit/user_cubit.dart';
import 'package:injectable/injectable.dart';
import 'store_state.dart';

@singleton
class StoreCubit extends Cubit<StoreState> {
  final UserCubit userCubit;
  StoreCubit(this.userCubit) : super(StoreState.idle());

  Future<void> purchase(int eggId, int price) async {
    emit(StoreState.buying());

    try {
      await userCubit.buyEgg(eggId, price);

      emit(StoreState.success(eggId));

      await Future.delayed(const Duration(milliseconds: 350));

      emit(StoreState.idle());
    } catch (_) {
      emit(StoreState.error());
    }
  }
}
