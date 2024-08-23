import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tutor_x_tution_management/color_pallete.dart';

class IconText extends StatelessWidget {
  final String text;
  final IconData icon;
  const IconText({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Pallete.gradiant9,
        ),
        const Gap(10),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
      ],
    );
  }
}
