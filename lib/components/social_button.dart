import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialButton extends StatelessWidget {
  final String iconPath;
  final String socialText;
  final double horizontalPadding;
  final void Function() onPressed;
  const SocialButton({
    super.key,
    required this.iconPath,
    required this.socialText,
    required this.horizontalPadding,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 25,
          horizontal: horizontalPadding,
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey.shade600,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: SvgPicture.asset(
        iconPath,
        width: 30,
      ),
      label: Text(
        socialText,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
