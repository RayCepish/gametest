import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/core/app/router/app_router.dart';
import 'package:game_test/core/constants/app_images.dart';
import 'package:game_test/core/services/audio_service.dart';
import 'package:game_test/dependency_injection/setup_dependency.dart';
import 'package:game_test/features/cubbits/app_lifecycle_cubit/app_lifecycle_cubit.dart';
import 'package:game_test/features/cubbits/profile_cubit/profile_cubit.dart';
import 'package:game_test/features/cubbits/settings_cubit/settings_cubit.dart';
import 'package:game_test/features/cubbits/store_cubit/store_cubit.dart';
import 'package:game_test/features/cubbits/user_cubit/user_cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _preloaded = false;

  @override
  void initState() {
    super.initState();

    unawaited(getIt<AudioService>().playMenuMusic());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<AppLifecycleCubit>()),
            BlocProvider(create: (_) => getIt<ProfileCubit>()),
            BlocProvider(create: (_) => getIt<SettingsCubit>()),
            BlocProvider(create: (_) => getIt<UserCubit>()..init()),
            BlocProvider(create: (_) => getIt<StoreCubit>()),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router,
            theme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.black,
            ),
            builder: (context, child) {
              if (!_preloaded) {
                _preloaded = true;

                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  for (final img in AppImages.all) {
                    await precacheImage(AssetImage(img), context);
                  }
                  debugPrint("✔️ ALL BACKGROUNDS PRELOADED");
                });
              }

              return child!;
            },
          ),
        );
      },
    );
  }
}
