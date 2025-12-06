part of 'glass_panel.dart';

class GlassPanelAnimation extends StatefulWidget {
  final Widget child;

  const GlassPanelAnimation({super.key, required this.child});

  @override
  State<GlassPanelAnimation> createState() => _GlassPanelAnimationState();
}

class _GlassPanelAnimationState extends State<GlassPanelAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _scale = Tween(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fade = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: FadeTransition(opacity: _fade, child: widget.child),
    );
  }
}
