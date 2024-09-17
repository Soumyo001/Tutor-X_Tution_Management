import 'dart:convert';

import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/models/student.dart';
import 'package:tutor_x_tution_management/models/tutor.dart';
import 'package:tutor_x_tution_management/models/user.dart';

class MessegeReciever extends StatelessWidget {
  final User user;
  final Tutor? tutor;
  final Student? student;
  const MessegeReciever(
      {super.key, required this.user, this.tutor, this.student});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 12.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 27,
                backgroundImage: user.userType == UserCategory.teacher
                    ? (tutor!.imageData != null
                        ? MemoryImage(base64Decode(tutor!.imageData!))
                        : null)
                    : (student!.imageData != null
                        ? MemoryImage(base64Decode(student!.imageData!))
                        : null),
                child: user.userType == UserCategory.teacher
                    ? (tutor!.imageData == null
                        ? Image.asset(
                            'lib/assets/images/profile_placeholder.jpg',
                            fit: BoxFit.fill,
                          )
                        : null)
                    : (student!.imageData == null
                        ? Image.asset(
                            'lib/assets/images/profile_placeholder.jpg',
                            fit: BoxFit.fill,
                          )
                        : null),
              ),
              const Gap(10),
              Text(
                user.fullName,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Divider(
            color: Colors.grey.shade400,
            height: 0.5,
          ),
        ),
      ],
    );
  }
}
