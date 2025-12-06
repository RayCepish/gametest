class StoreState {
  final bool buying;
  final int? purchasedEggId;

  StoreState({required this.buying, this.purchasedEggId});

  factory StoreState.idle() => StoreState(buying: false);
  factory StoreState.buying() => StoreState(buying: true);
  factory StoreState.success(int eggId) =>
      StoreState(buying: false, purchasedEggId: eggId);
  factory StoreState.error() => StoreState(buying: false);
}
