import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tutor_x_tution_management/components/icon_button.dart';
import 'package:tutor_x_tution_management/components/profile_edit_item_student_medium.dart';
import 'package:tutor_x_tution_management/components/profile_edit_item_student_type.dart';
import 'package:tutor_x_tution_management/components/profile_edit_item_subject_of_interest.dart';
import 'package:tutor_x_tution_management/components/profile_edit_item_tutor_status.dart';

class TutorSelectionEdit extends StatelessWidget {
  final void Function() onSelectionDone;
  const TutorSelectionEdit({super.key, required this.onSelectionDone});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProfileEditTutorStatus(),
        const Gap(7),
        const ProfileEditSOI(),
        const Gap(7),
        const ProfileEditSM(isTutor: true),
        const Gap(7),
        const ProfileEditST(),
        const Gap(10),
        ButtonIcon(
          label: 'Save',
          icon: Icons.save,
          onPressed: onSelectionDone,
          enableIcon: true,
          loading: false,
        ),
      ],
    );
  }
}
