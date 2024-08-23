import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:tutor_x_tution_management/components/icon_text.dart';
import 'package:tutor_x_tution_management/components/tutor_profile_extra_info.dart';
import 'package:tutor_x_tution_management/models/tutor.dart';
import 'package:tutor_x_tution_management/models/user.dart';

class OtherTutorProfileViewPartRight extends StatefulWidget {
  final Tutor tutor;
  final User user;
  const OtherTutorProfileViewPartRight(
      {super.key, required this.tutor, required this.user});

  @override
  State<OtherTutorProfileViewPartRight> createState() =>
      _OtherTutorProfileViewPartRightState();
}

class _OtherTutorProfileViewPartRightState
    extends State<OtherTutorProfileViewPartRight> {
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
            TutorProfileExtraInfo(
              extraInfo:
                  widget.tutor.status.toString().split('.').last.toUpperCase(),
              label: 'Status',
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
                extraInfo:
                    widget.tutor.mediumOfInterest.toString().split('.').last,
                label: 'Medium of Interest'),
            TutorProfileExtraInfo(
                extraInfo: widget.tutor.expectedStudent
                    .toString()
                    .split('.')
                    .last
                    .replaceAll('_', ' '),
                label: 'Expected Student'),
            TutorProfileExtraInfo(
                extraInfo: widget.tutor.subjectOfInterest
                    .toString()
                    .split('.')
                    .last
                    .replaceAll('_', ' '),
                label: 'Subject of Interest'),
            TutorProfileExtraInfo(
                extraInfo: '${widget.tutor.expectedSalary.toString()} BDT',
                label: 'Expected Salary'),
            TutorProfileExtraInfo(
                extraInfo: widget.tutor.tutorSelfDescription, label: 'Bio'),
          ],
        ),
      ),
    );
  }
}
