import 'package:flutter/material.dart';
import 'package:game_test/core/constants/app_images.dart';
import 'package:game_test/core/widgets/layouts/static_background.dart';

class MainLayout extends StatelessWidget {
  final Widget? appBar;
  final Widget child;
  final String? backgroundImage;

  const MainLayout({
    super.key,
    required this.child,
    this.backgroundImage,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundImage ?? AppImages.bgMain;

    return Scaffold(
      body: Stack(
        children: [
          StaticBackground(image: bg),

          if (appBar != null)
            Positioned(
              top: MediaQuery.of(context).padding.top + 12,
              left: 20,
              right: 20,
              child: appBar!,
            ),

          Positioned.fill(
            child: Column(
              children: [
                SizedBox(height: appBar != null ? 110 : 0),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
