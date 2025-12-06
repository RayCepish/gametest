import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/constants/app_images.dart';
import 'package:game_test/core/constants/app_sounds.dart';
import 'package:game_test/core/widgets/animated_button/animated_button.dart';
import 'package:game_test/core/widgets/game_app_bar/game_app_bar.dart';
import 'package:game_test/core/widgets/layouts/main_layout.dart';
import 'package:game_test/dependency_injection/setup_dependency.dart';
import 'package:game_test/domain/usecases/audio_usecases/play_audio_usecase.dart';
import 'package:game_test/features/cubbits/settings_cubit/settings_cubit.dart';
import 'package:game_test/features/screens/main_app_screen/widgets/chicken_animated.dart';
import 'package:game_test/features/screens/main_app_screen/widgets/progress_bar.dart';
import 'package:go_router/go_router.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _scaleController;

  late Animation<double> _progressAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _playOpacityAnimation;
  late Animation<Offset> _slideAnimation;
  bool _showButtons = false;
  @override
  void initState() {
    super.initState();

    final settings = getIt<SettingsCubit>().state;

    if (settings.sound) {
      unawaited(getIt<PlayAudioUseCase>().call(AppMusic.menu));
    }

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.78).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );

    _playOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _scaleController, curve: const Interval(0.4, 1)),
    );

    _slideAnimation =
        Tween<Offset>(
          begin: const Offset(0, 0),
          end: const Offset(0, -0.10),
        ).animate(
          CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
        );

    _progressController.forward().then((_) {
      setState(() => _showButtons = true);
      _scaleController.forward();
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBar: FadeTransition(
        opacity: _playOpacityAnimation,

        child: GameAppBar(
          leftButtonImage: AppImages.btnInfo,
          onLeftTap: () {
            context.pushNamed('how_to_play');
          },
          rightButtonImage: AppImages.btnMenu,
          onRightTap: () {
            context.pushNamed('menu');
          },
        ),
      ),
      child: Stack(
        children: [
          ChickenAnimated(
            scaleAnimation: _scaleAnimation,
            slideAnimation: _slideAnimation,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RepaintBoundary(
              child: Padding(
                padding: EdgeInsets.only(bottom: 120.h),
                child: _showButtons
                    ? FadeTransition(
                        opacity: _playOpacityAnimation,
                        child: AnimatedButton(
                          imagePath: AppImages.btnPlay,
                          onTap: () {
                            context.goNamed('levels');
                          },
                        ),
                      )
                    : ProgressBar(animation: _progressAnimation),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
