import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/constants/app_images.dart';
import 'package:game_test/core/widgets/animated_button/animated_button.dart';
import 'package:game_test/core/widgets/avatar_frame.dart';
import 'package:game_test/core/widgets/bottom_sheet.dart';
import 'package:game_test/core/widgets/game_app_bar/game_app_bar.dart';
import 'package:game_test/core/widgets/glass_panel/glass_panel.dart';
import 'package:game_test/core/widgets/layouts/main_layout.dart';
import 'package:game_test/core/widgets/pickAvatar.dart';
import 'package:game_test/core/widgets/stroke_text.dart';
import 'package:game_test/features/cubbits/profile_cubit/profile_cubit.dart';
import 'package:game_test/features/cubbits/profile_cubit/profile_state.dart';
import 'package:game_test/features/screens/profile_screen/widgets/input_field.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();

        return MainLayout(
          appBar: GameAppBar(
            leftButtonImage: AppImages.btnBack,
            onLeftTap: () => context.pop(),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GlassPanel(
                  height: 450.h,
                  animated: true,
                  child: Column(
                    children: [
                      StrokeText("PROFILE", fontSize: 32.sp),
                      SizedBox(height: 20.h),
                      AvatarFrame(
                        image: state.profile.avatarPath,
                        onEdit: () async {
                          final choice = await showAvatarPicker(context);
                          if (choice == null) return;

                          final path = await pickAvatar(choice);
                          if (path != null) {
                            cubit.updateAvatar(path);
                          }
                        },
                      ),

                      SizedBox(height: 20.h),

                      InputField(
                        label: "USERNAME",
                        initial: state.profile.name,
                        onChanged: cubit.updateName,
                      ),

                      SizedBox(height: 16.h),

                      InputField(
                        label: "EMAIL",
                        initial: state.profile.email,
                        onChanged: cubit.updateEmail,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 25.h),

                AnimatedButton(
                  imagePath: AppImages.btnSave,
                  width: 230,
                  onTap: () => cubit.save(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
