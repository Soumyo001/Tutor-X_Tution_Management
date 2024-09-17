import 'package:flutter/material.dart';
import 'package:tutor_x_tution_management/utils/color_pallete.dart';

class LogSignButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const LogSignButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.all(18),
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [Pallete.gradiant3, Pallete.gradiant2],
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
