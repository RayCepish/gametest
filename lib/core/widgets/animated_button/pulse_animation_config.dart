part of 'animated_button.dart';

class PulseAnimationConfig {
  final Duration? duration;
  final double minScale;
  final double maxScale;

  const PulseAnimationConfig({
    this.duration,
    required this.minScale,
    required this.maxScale,
  });

  static const soft = PulseAnimationConfig(
    duration: Duration(seconds: 2),
    minScale: 1.00,
    maxScale: 1.02,
  );

  static const medium = PulseAnimationConfig(
    duration: Duration(seconds: 2),
    minScale: 1.01,
    maxScale: 1.05,
  );

  static const strong = PulseAnimationConfig(
    duration: Duration(milliseconds: 900),
    minScale: 0.90,
    maxScale: 1.08,
  );
  static const none = PulseAnimationConfig(
    duration: null,
    minScale: 1.0,
    maxScale: 1.0,
  );
}
