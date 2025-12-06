import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/widgets/stroke_text.dart';

class ProgressBar extends StatelessWidget {
  final Animation<double> animation;

  const ProgressBar({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      child: AnimatedBuilder(
        animation: animation,
        builder: (_, __) {
          final value = 0.1 + animation.value * 0.9;

          return Container(
            height: 32.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: Colors.white.withOpacity(0.75),
            ),
            child: Stack(
              children: [
                FractionallySizedBox(
                  widthFactor: value,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 255, 55, 55),
                          Color.fromARGB(255, 255, 152, 0),
                          Color.fromARGB(255, 255, 193, 7),
                        ],
                      ),
                    ),
                  ),
                ),

                Center(child: StrokeText('${(value * 100).toInt()}%')),
              ],
            ),
          );
        },
      ),
    );
  }
}
