import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/components/icon_button.dart';
import 'package:tutor_x_tution_management/components/icon_text.dart';
import 'package:tutor_x_tution_management/components/tutor_profile_extra_info.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'package:tutor_x_tution_management/routes/route.dart';

class TutorProfileViewRightPart extends StatefulWidget {
  const TutorProfileViewRightPart({super.key});

  @override
  State<TutorProfileViewRightPart> createState() =>
      _TutorProfileViewRightPartState();
}

class _TutorProfileViewRightPartState extends State<TutorProfileViewRightPart> {
  late final UserStaticsController _userStaticsController;

  @override
  void initState() {
    super.initState();
    _userStaticsController = Get.find<UserStaticsController>();
  }

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
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const IconText(
                    text: 'More Information',
                    icon: Icons.info_outlined,
                  ),
                  ButtonIcon(
                    label: 'Edit',
                    icon: Icons.edit,
                    onPressed: () {
                      Get.toNamed(WebRoutes.tutorProfileEditPage);
                    },
                    enableIcon: true,
                    loading: false,
                  ),
                ],
              ),
            ),
            const Gap(5),
            Obx(
              () => TutorProfileExtraInfo(
                extraInfo: _userStaticsController.tutorAvailabilityStatus
                    .toString()
                    .split('.')
                    .last
                    .toUpperCase(),
                label: 'Status',
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
            Obx(
              () => TutorProfileExtraInfo(
                  extraInfo: _userStaticsController.tutorStudentMedium
                      .toString()
                      .split('.')
                      .last,
                  label: 'Medium of Interest'),
            ),
            Obx(
              () => TutorProfileExtraInfo(
                  extraInfo: _userStaticsController.tutorStudentType
                      .toString()
                      .split('.')
                      .last
                      .replaceAll('_', ' '),
                  label: 'Expected Student'),
            ),
            Obx(
              () => TutorProfileExtraInfo(
                  extraInfo: _userStaticsController.tutorSubjectType
                      .toString()
                      .split('.')
                      .last
                      .replaceAll('_', ' '),
                  label: 'Subject of Interest'),
            ),
            Obx(
              () => TutorProfileExtraInfo(
                  extraInfo:
                      '${_userStaticsController.tutorSalary.toString()} BDT',
                  label: 'Expected Salary'),
            ),
            Obx(
              () => TutorProfileExtraInfo(
                  extraInfo: _userStaticsController.tutorSelfDesc,
                  label: 'Bio'),
            ),
          ],
        ),
      ),
    );
  }
}
