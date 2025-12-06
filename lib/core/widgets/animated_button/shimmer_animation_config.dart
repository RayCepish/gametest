part of 'animated_button.dart';

class ShimmerAnimationConfig {
  final bool enabled;
  final Duration duration;
  final Duration interval;
  final double opacity;
  final ShimmerDirection direction;

  const ShimmerAnimationConfig({
    this.enabled = true,
    this.duration = const Duration(seconds: 1),
    this.interval = const Duration(seconds: 3),
    this.opacity = 0.2,
    this.direction = const ShimmerDirection.fromLeftToRight(),
  });

  static ShimmerAnimationConfig random() {
    final rnd = Random();

    final randomInterval = Duration(seconds: rnd.nextInt(10) + 4);

    final directions = <ShimmerDirection>[
      ShimmerDirection.fromLTRB(),
      ShimmerDirection.fromRTLB(),
      ShimmerDirection.fromLBRT(),
      ShimmerDirection.fromRBLT(),
    ];

    final randomDirection = directions[rnd.nextInt(directions.length)];

    return ShimmerAnimationConfig(
      interval: randomInterval,
      direction: randomDirection,
    );
  }
}
