import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:tutor_x_tution_management/components/icon_text.dart';
import 'package:tutor_x_tution_management/components/tutor_profile_extra_info.dart';
import 'package:tutor_x_tution_management/models/student.dart';
import 'package:tutor_x_tution_management/models/user.dart';

class OtherStudentProfileViewPartRight extends StatefulWidget {
  final Student student;
  final User user;
  const OtherStudentProfileViewPartRight(
      {super.key, required this.student, required this.user});

  @override
  State<OtherStudentProfileViewPartRight> createState() =>
      _OtherStudentProfileViewPartRightState();
}

class _OtherStudentProfileViewPartRightState
    extends State<OtherStudentProfileViewPartRight> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        height: screenSize.height * 0.8,
        width: screenSize.width / 2.1,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500.withAlpha(150),
              blurRadius: 16,
              spreadRadius: 1,
              offset: const Offset(2, 2),
            ),
            BoxShadow(
              color: Colors.grey.shade500.withAlpha(150),
              blurRadius: 16,
              spreadRadius: 1,
              offset: const Offset(-2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(22.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconText(
                    text: 'More Information',
                    icon: Icons.info_outlined,
                  ),
                ],
              ),
            ),
            const Gap(5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(
                color: Colors.grey.shade500.withAlpha(150),
                thickness: 0.5,
                height: 0.5,
              ),
            ),
            const Gap(5),
            TutorProfileExtraInfo(
                extraInfo: widget.student.firstName.toString().split('.').last,
                label: 'First Name'),
            TutorProfileExtraInfo(
                extraInfo: widget.student.lastName
                    .toString()
                    .split('.')
                    .last
                    .replaceAll('_', ' '),
                label: 'Last Name'),
            TutorProfileExtraInfo(
                extraInfo: widget.student.studentMedium
                    .toString()
                    .split('.')
                    .last
                    .replaceAll('_', ' '),
                label: 'Student Medium'),
            TutorProfileExtraInfo(
                extraInfo: widget.user.education, label: 'Education'),
            TutorProfileExtraInfo(
                extraInfo: widget.student.studentSelfDescription, label: 'Bio'),
          ],
        ),
      ),
    );
  }
}
