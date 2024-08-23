import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/components/icon_button.dart';
import 'package:tutor_x_tution_management/components/icon_text.dart';
import 'package:tutor_x_tution_management/components/tutor_profile_extra_info.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'package:tutor_x_tution_management/routes/route.dart';

class StudentProfileViewRight extends StatefulWidget {
  const StudentProfileViewRight({super.key});

  @override
  State<StudentProfileViewRight> createState() =>
      _StudentProfileViewRightState();
}

class _StudentProfileViewRightState extends State<StudentProfileViewRight> {
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
        height: screenSize.height * 0.7,
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
              padding: const EdgeInsets.all(20.0),
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
                      Get.toNamed(WebRoutes.studentProfileEditPage);
                    },
                    enableIcon: true,
                    loading: false,
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
            Obx(
              () => TutorProfileExtraInfo(
                  extraInfo: _userStaticsController.student!.firstName
                      .toString()
                      .split('.')
                      .last,
                  label: 'First Name'),
            ),
            Obx(
              () => TutorProfileExtraInfo(
                  extraInfo: _userStaticsController.student!.lastName
                      .toString()
                      .split('.')
                      .last
                      .replaceAll('_', ' '),
                  label: 'Last Name'),
            ),
            Obx(
              () => TutorProfileExtraInfo(
                  extraInfo: _userStaticsController.studentMedium
                      .toString()
                      .split('.')
                      .last
                      .replaceAll('_', ' '),
                  label: 'Student Medium'),
            ),
            Obx(
              () => TutorProfileExtraInfo(
                  extraInfo: _userStaticsController.userEducation,
                  label: 'Education'),
            ),
            Obx(
              () => TutorProfileExtraInfo(
                  extraInfo: _userStaticsController.studentSelfDesc,
                  label: 'Bio'),
            ),
          ],
        ),
      ),
    );
  }
}
