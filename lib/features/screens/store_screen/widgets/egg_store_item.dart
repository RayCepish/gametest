import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/constants/app_images.dart';
import 'package:game_test/core/constants/egg_config.dart';
import 'package:game_test/core/widgets/stroke_text.dart';

class EggStoreItem extends StatelessWidget {
  final EggConfig egg;
  final bool owned;
  final bool isAnimating;
  final VoidCallback? onTap;

  const EggStoreItem({
    super.key,
    required this.egg,
    required this.owned,
    required this.isAnimating,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: owned ? null : onTap,
      child: AnimatedScale(
        scale: isAnimating ? 1.12 : 1.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,

        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            color: Colors.black.withOpacity(0.45),
            border: Border.all(
              color: owned ? Colors.greenAccent : Colors.white.withOpacity(0.7),
              width: owned ? 3 : 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(egg.asset, width: 48.w, height: 48.w),
              SizedBox(height: 6.h),
              StrokeText(
                egg.name,
                fontSize: 13.sp,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 6.h),

              owned
                  ? Expanded(
                      child: StrokeText(
                        "OWNED",
                        fontSize: 12.sp,
                        textColor: Colors.greenAccent,
                        strokeColor: Colors.black,
                      ),
                    )
                  : Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StrokeText(
                            "${egg.price}",
                            fontSize: 12.sp,
                            textColor: Colors.yellow,
                          ),
                          SizedBox(width: 4.w),
                          Image.asset(AppImages.gold, width: 16.w),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
