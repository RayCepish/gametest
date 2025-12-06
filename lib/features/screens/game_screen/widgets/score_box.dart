import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/widgets/glass_panel/glass_panel.dart';

class ScoreBox extends StatelessWidget {
  final String label;
  final int value;

  const ScoreBox({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      width: 150.w,
      height: 60.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value.toString().padLeft(4, '0'),
            style: TextStyle(
              color: Colors.greenAccent,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
