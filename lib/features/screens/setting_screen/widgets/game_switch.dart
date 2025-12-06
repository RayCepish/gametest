import 'package:flutter/material.dart';

class GameSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const GameSwitch({super.key, required this.value, required this.onChanged});

  @override
  State<GameSwitch> createState() => _GameSwitchState();
}

class _GameSwitchState extends State<GameSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      value: widget.value ? 1.0 : 0.0,
    );
  }

  @override
  void didUpdateWidget(GameSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      widget.value ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: SizedBox(
        width: 60,
        height: 32,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            final t = _controller.value;

            return Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  width: 60,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    gradient: LinearGradient(
                      colors: widget.value
                          ? [Colors.green.shade500, Colors.green.shade700]
                          : [Colors.grey.shade300, Colors.grey.shade500],
                    ),
                  ),
                ),

                Positioned(
                  left: 4 + (t * 28),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 3,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
