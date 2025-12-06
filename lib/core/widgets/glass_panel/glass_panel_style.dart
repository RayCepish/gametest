part of 'glass_panel.dart';

class GlassPanelStyle {
  static final BoxDecoration defaultDecoration = BoxDecoration(
    color: const Color(0xAA7A027A),
    borderRadius: BorderRadius.circular(24.r),
    border: Border.all(
      //TODO v colors
      color: const Color(0xFFFF6CD8),
      width: 2,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.25),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ],
  );
}
