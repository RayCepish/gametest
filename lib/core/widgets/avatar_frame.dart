import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/constants/app_images.dart';

class AvatarFrame extends StatelessWidget {
  final String? image;
  final VoidCallback? onEdit;
  final double frameSize;
  final double avatarSize;

  const AvatarFrame({
    super.key,
    required this.image,
    this.onEdit,
    this.frameSize = 140,
    double? avatarSize,
  }) : avatarSize = avatarSize ?? frameSize * 0.7;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: frameSize.w,
      height: frameSize.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            AppImages.emptyFrame,
            width: frameSize.w,
            height: frameSize.w,
            fit: BoxFit.contain,
          ),

          Align(
            alignment: const Alignment(0, -0.2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: SizedBox(
                width: avatarSize.w,
                height: avatarSize.w,
                child: image == null
                    ? Image.asset(AppImages.userDefAvatar, fit: BoxFit.cover)
                    : Image(
                        image: image!.startsWith("/")
                            ? FileImage(File(image!))
                            : AssetImage(image!) as ImageProvider,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),

          if (onEdit != null)
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: onEdit,
                child: Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: const BoxDecoration(
                    color: Color(0xFF43B805),
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: Icon(Icons.edit, color: Colors.white, size: 16.sp),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
