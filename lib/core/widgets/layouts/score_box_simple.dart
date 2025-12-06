import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/widgets/stroke_text.dart';

class ScoreBoxSimple extends StatelessWidget {
  final String label;
  final int value;

  const ScoreBoxSimple({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.9.sw,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF43B805),

        borderRadius: BorderRadius.circular(14.r),

        border: Border.all(color: const Color(0xFF006B1E), width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StrokeText(label, strokeWidth: 0.2, fontSize: 26),
          StrokeText(
            value.toString().padLeft(4, '0'),
            strokeWidth: 0.2,
            fontSize: 26,
          ),
        ],
      ),
    );
  }
}
