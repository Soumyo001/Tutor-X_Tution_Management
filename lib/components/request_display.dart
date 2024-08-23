import 'dart:convert';

import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:tutor_x_tution_management/color_pallete.dart';
import 'package:tutor_x_tution_management/components/just_icon.dart';
import 'package:tutor_x_tution_management/components/tutor_profile_extra_info.dart';

class RequestDisplay extends StatelessWidget {
  final String education, fullName;
  final String? imageData;
  final void Function()? onAccept;
  final void Function()? onDecline;
  const RequestDisplay({
    super.key,
    required this.education,
    required this.fullName,
    required this.imageData,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Pallete.requestColor.withAlpha(150),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
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
              const Gap(10),
              TutorProfileExtraInfo(
                extraInfo: education,
                label: fullName,
                labelColor: Pallete.buttonColor,
                extraInfoColor: Colors.black,
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              JustIcon(
                icon: Icons.check,
                onPressed: onAccept,
              ),
              const Gap(5),
              JustIcon(
                icon: Icons.highlight_remove_rounded,
                onPressed: onDecline,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
