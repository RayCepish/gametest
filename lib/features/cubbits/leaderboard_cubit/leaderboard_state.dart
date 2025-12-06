part of 'leaderboard_cubit.dart';

abstract class LeaderboardState {}

class LeaderboardLoading extends LeaderboardState {}

class LeaderboardLoaded extends LeaderboardState {
  final UserEntity currentUser;
  final List<UserEntity> users;

  LeaderboardLoaded({required this.currentUser, required this.users});
}
