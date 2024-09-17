import 'dart:convert';

import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:tutor_x_tution_management/color_pallete.dart';
import 'package:tutor_x_tution_management/components/icon_button.dart';
import 'package:tutor_x_tution_management/components/tutor_profile_extra_info.dart';

class FriendDisplayWidget extends StatelessWidget {
  final String? imageData;
  final String fullName;
  final String education;
  final void Function()? onPressed;
  const FriendDisplayWidget(
      {super.key,
      required this.imageData,
      required this.fullName,
      required this.education,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Pallete.gradiant9.withAlpha(20),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Gap(5),
              CircleAvatar(
                radius: 40,
                backgroundImage: imageData != null
                    ? MemoryImage(base64Decode(imageData!))
                    : null,
                child: imageData == null
                    ? Image.asset(
                        'lib/assets/images/profile_placeholder.jpg',
                        fit: BoxFit.fill,
                      )
                    : null,
              ),
              const Gap(5),
              TutorProfileExtraInfo(
                extraInfo: education,
                label: fullName,
                labelColor: Pallete.buttonColor,
                extraInfoColor: Colors.black,
              ),
              const Gap(5),
            ],
          ),
          ButtonIcon(
            label: 'Friends',
            icon: Icons.person,
            onPressed: onPressed,
            enableIcon: true,
            loading: false,
          ),
        ],
      ),
    );
  }
}
