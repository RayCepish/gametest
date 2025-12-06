import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/widgets/avatar_frame.dart';
import 'package:game_test/core/widgets/stroke_text.dart';

class LeaderboardTile extends StatelessWidget {
  final String username;
  final String score;
  final bool isCurrentUser;
  final String? avatar;
  final bool useAvatarFrame;

  const LeaderboardTile({
    super.key,
    required this.username,
    required this.score,
    this.isCurrentUser = false,
    this.avatar,
    this.useAvatarFrame = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isCurrentUser ? Colors.yellow : Colors.white;

    return SizedBox(
      height: 70.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 50.w,
            right: 0,
            top: 10.h,
            bottom: 10.h,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFF4FD4),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                  width: 2,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StrokeText(
                    username,
                    fontSize: 20.sp,
                    strokeWidth: 2,
                    // strokeColor: Colors.black.withOpacity(0.4),
                    textColor: textColor,
                  ),
                  StrokeText(
                    score,
                    fontSize: 20.sp,
                    strokeWidth: 2,
                    // strokeColor: Colors.black.withOpacity(0.4),
                    textColor: textColor,
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            left: 0,
            top: 0,
            child: AvatarFrame(image: avatar, frameSize: 70),
          ),
        ],
      ),
    );
  }
}
