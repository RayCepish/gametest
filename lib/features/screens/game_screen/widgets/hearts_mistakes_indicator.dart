import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeartsMistakesIndicator extends StatelessWidget {
  final int mistakes;
  final int maxMistakes;

  const HeartsMistakesIndicator({
    super.key,
    required this.mistakes,
    required this.maxMistakes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(maxMistakes, (index) {
        final isLost = index >= maxMistakes - mistakes;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: AnimatedScale(
            scale: isLost ? 0.85 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              Icons.favorite,
              size: 22.w,
              color: isLost ? Colors.grey.shade600 : Colors.redAccent,
            ),
          ),
        );
      }),
    );
  }
}
