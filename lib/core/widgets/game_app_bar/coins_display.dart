import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/constants/app_images.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CoinsDisplay extends StatelessWidget {
  final int value;

  const CoinsDisplay({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 90.w,
            height: 33.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFF7A00),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: const Color(0xFFFF3B00), width: 1),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '$value',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Positioned(
            right: -20.w,
            top: -8.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.r),

              child: Shimmer(
                duration: const Duration(seconds: 2),
                interval: const Duration(seconds: 10),
                color: Colors.yellow,
                colorOpacity: 0.3,
                direction: const ShimmerDirection.fromLTRB(),
                child: Image.asset(AppImages.gold, width: 50.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
