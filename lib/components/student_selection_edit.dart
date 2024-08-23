import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:tutor_x_tution_management/components/icon_button.dart';
import 'package:tutor_x_tution_management/components/profile_edit_item_student_medium.dart';

class StudentSelectionEdit extends StatelessWidget {
  final void Function() onSelectionDone;
  const StudentSelectionEdit({super.key, required this.onSelectionDone});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProfileEditSM(
          isTutor: false,
        ),
        const Gap(7),
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
