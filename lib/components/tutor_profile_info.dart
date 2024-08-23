import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tutor_x_tution_management/color_pallete.dart';

class TutorProfileInfo extends StatelessWidget {
  final String info;
  final IconData icon;
  const TutorProfileInfo({
    super.key,
    required this.info,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Gap(10),
        Icon(
          icon,
          size: 30,
          color: Pallete.gradiant9,
        ),
        const Gap(10),
        Text(
          info,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
        ),
      ],
    );
  }
}
