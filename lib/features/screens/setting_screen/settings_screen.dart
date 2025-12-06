import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/constants/app_images.dart';
import 'package:game_test/core/widgets/animated_button/animated_button.dart';
import 'package:game_test/core/widgets/game_app_bar/game_app_bar.dart';
import 'package:game_test/core/widgets/glass_panel/glass_panel.dart';
import 'package:game_test/core/widgets/layouts/main_layout.dart';
import 'package:game_test/core/widgets/stroke_text.dart';
import 'package:game_test/core/services/audio_service.dart';
import 'package:game_test/core/services/vibration_service.dart';
import 'package:game_test/dependency_injection/setup_dependency.dart';
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
        final audio = getIt<AudioService>();
        final vibration = getIt<VibrationService>();

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
                          onChanged: (v) {
                            cubit.updateSound(v);
                            v ? audio.stop() : audio.stop();
                          },
                        ),

                        SettingTile(
                          label: "VIBRATION",
                          value: state.vibration,
                          onChanged: (v) {
                            cubit.updateVibration(v);
                            vibration.enabled = v;
                            if (v) vibration.vibrateLight();
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 25.h),

                  ScaleTransition(
                    scale: cubit.hasUnsavedChanges
                        ? _pulseController
                        : const AlwaysStoppedAnimation(1.0),
                    child: AnimatedButton(
                      imagePath: AppImages.btnSave,
                      width: 230,
                      onTap: () async {
                        await cubit.save();
                      },
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
