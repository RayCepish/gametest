part of 'game_app_bar.dart';

class AppBarButton extends StatelessWidget {
  final String image;
  final VoidCallback? onTap;

  const AppBarButton({super.key, required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(image, width: 65.w),
    );
  }
}
