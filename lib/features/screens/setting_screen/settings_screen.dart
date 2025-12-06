import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/constants/app_images.dart';
import 'package:game_test/core/constants/color_filter.dart';
import 'package:game_test/core/widgets/animated_button/animated_button.dart';
import 'package:game_test/core/widgets/game_app_bar/game_app_bar.dart';
import 'package:game_test/core/widgets/glass_panel/glass_panel.dart';
import 'package:game_test/core/widgets/layouts/main_layout.dart';
import 'package:game_test/core/widgets/stroke_text.dart';

import 'package:game_test/domain/entities/settings_entity.dart';
import 'package:game_test/features/cubbits/settings_cubit/settings_cubit.dart';
import 'package:game_test/features/screens/setting_screen/widgets/setting_tile.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
      lowerBound: 0.9,
      upperBound: 1.05,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsEntity>(
      builder: (context, state) {
        final cubit = context.read<SettingsCubit>();

        return PopScope(
          canPop: true,
          onPopInvoked: (didPop) {
            if (didPop) {
              cubit.revert();
            }
          },
          child: MainLayout(
            appBar: GameAppBar(
              leftButtonImage: AppImages.btnBack,
              onLeftTap: () {
                cubit.revert();
                context.pop();
              },
            ),

            child: Padding(
              padding: EdgeInsets.only(top: 40.h, bottom: 40.h),
              child: Column(
                children: [
                  GlassPanel(
                    child: Column(
                      children: [
                        StrokeText("SETTINGS", fontSize: 32.sp),
                        SizedBox(height: 20.h),

                        SettingTile(
                          label: "SOUND",
                          value: state.sound,
                          onChanged: cubit.updateSound,
                        ),

                        SettingTile(
                          label: "VIBRATION",
                          value: state.vibration,
                          onChanged: cubit.updateVibration,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 25.h),

                  ScaleTransition(
                    scale: cubit.hasUnsavedChanges
                        ? _pulseController
                        : const AlwaysStoppedAnimation(1.0),

                    child: ColorFiltered(
                      colorFilter: cubit.hasUnsavedChanges
                          ? const ColorFilter.mode(
                              Colors.transparent,
                              BlendMode.dst,
                            )
                          : grayslakeFilter,

                      child: IgnorePointer(
                        ignoring: !cubit.hasUnsavedChanges,
                        child: AnimatedButton(
                          imagePath: AppImages.btnSave,
                          width: 230,
                          pulseAnimationConfig: cubit.hasUnsavedChanges
                              ? PulseAnimationConfig.medium
                              : PulseAnimationConfig.none,

                          onTap: () async {
                            await cubit.save();
                            context.pop();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
