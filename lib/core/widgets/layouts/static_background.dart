import 'package:flutter/material.dart';

class StaticBackground extends StatelessWidget {
  final String image;
  const StaticBackground({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
