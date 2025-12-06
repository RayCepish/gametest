import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<String?> showAvatarPicker(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: const Color(0xFF2D2D2D),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
    ),
    builder: (context) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 24.h,
          bottom: 24.h + MediaQuery.of(context).padding.bottom,
          left: 20.w,
          right: 20.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "PLEASE MAKE YOUR CHOICE",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 26.h),

            // === BIG COMBINED BUTTON ===
            _BigDoubleButton(
              onTopTap: () => Navigator.pop(context, "camera"),
              onBottomTap: () => Navigator.pop(context, "gallery"),
            ),

            SizedBox(height: 20.h),

            // === CANCEL ===
            _CancelBtn(onTap: () => Navigator.pop(context, null)),
          ],
        ),
      );
    },
  );
}

class _BigDoubleButton extends StatelessWidget {
  final VoidCallback onTopTap;
  final VoidCallback onBottomTap;

  const _BigDoubleButton({required this.onTopTap, required this.onBottomTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            GestureDetector(
              onTap: onTopTap,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 18.h),
                child: Text(
                  "MAKE A PHOTO",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Container(height: 1, width: 0.70.sw, color: Colors.black),

            GestureDetector(
              onTap: onBottomTap,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 18.h),
                child: Text(
                  "CHOOSE PHOTO",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CancelBtn extends StatelessWidget {
  final VoidCallback onTap;

  const _CancelBtn({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        width: 120.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Text(
            "CANCEL",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
