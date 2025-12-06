import 'package:flutter/material.dart';

class StrokeText extends StatelessWidget {
  final String text;
  final double fontSize;
  final double strokeWidth;
  final Color strokeColor;
  final Color textColor;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  final bool underline;
  final double underlineHeight;
  final Color underlineColor;

  const StrokeText(
    this.text, {
    super.key,
    this.fontSize = 24,
    this.strokeWidth = 1,
    this.strokeColor = const Color(0xFFE236A8),
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.w900,
    this.textAlign = TextAlign.center,
    this.underline = false,
    this.underlineHeight = 2,
    this.underlineColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            // Stroke
            Text(
              text,
              textAlign: textAlign,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = strokeWidth
                  ..color = strokeColor,
              ),
            ),

            // Fill text
            Text(
              text,
              textAlign: textAlign,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: textColor,
              ),
            ),

            if (underline)
              Positioned(
                bottom: 3,
                child: Container(
                  height: underlineHeight,
                  width: _textWidth(text, fontSize, fontWeight),
                  color: underlineColor,
                ),
              ),
          ],
        );
      },
    );
  }

  // Рахуємо ширину тексту
  double _textWidth(String text, double size, FontWeight weight) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: size, fontWeight: weight),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    return painter.width;
  }
}
