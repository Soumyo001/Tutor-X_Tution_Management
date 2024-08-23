import 'package:flutter/Material.dart';
import 'package:tutor_x_tution_management/color_pallete.dart';

class JustIcon extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;
  const JustIcon({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          surfaceTintColor: Pallete.buttonColor2.withAlpha(50),
          backgroundColor: Pallete.buttonColor,
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
