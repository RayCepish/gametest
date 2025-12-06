import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_test/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:game_test/domain/repositories/user_repository.dart';

part 'leaderboard_state.dart';

@injectable
class LeaderboardCubit extends Cubit<LeaderboardState> {
  final UserRepository repo;

  LeaderboardCubit(this.repo) : super(LeaderboardLoading());

  Future<void> load() async {
    emit(LeaderboardLoading());

    final current = await repo.getUser();
    final list = await repo.getLeaderboard(current);

    emit(LeaderboardLoaded(currentUser: current, users: list));
  }
}
