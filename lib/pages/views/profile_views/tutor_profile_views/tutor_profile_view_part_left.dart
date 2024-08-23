import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/components/icon_button.dart';
import 'package:tutor_x_tution_management/components/tutor_profile_info.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'package:tutor_x_tution_management/routes/route.dart';

class TutorProfileViewLeftPart extends StatefulWidget {
  const TutorProfileViewLeftPart({super.key});

  @override
  State<TutorProfileViewLeftPart> createState() =>
      _TutorProfileViewLeftPartState();
}

class _TutorProfileViewLeftPartState extends State<TutorProfileViewLeftPart> {
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
      alignment: Alignment.topLeft,
      child: Container(
        height: screenSize.height,
        width: screenSize.width / 2,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500.withAlpha(150),
              blurRadius: 16,
              spreadRadius: 1,
              offset: const Offset(5, 5),
            ),
            BoxShadow(
              color: Colors.grey.shade500.withAlpha(150),
              blurRadius: 16,
              spreadRadius: 1,
              offset: const Offset(-5, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: screenSize.height * 0.53,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Obx(
                    () => _userStaticsController.imageData == null
                        ? Image.asset(
                            'lib/assets/images/profile_placeholder.jpg',
                            fit: BoxFit.fitHeight,
                          )
                        : Image.memory(
                            _userStaticsController.imageData!,
                            fit: BoxFit.fitHeight,
                          ),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) => Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * 0.15,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.shade200.withAlpha(150),
                      ),
                      child: Text(
                        _userStaticsController.userName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonIcon(
                    icon: Icons.post_add_rounded,
                    label: 'Add Post',
                    onPressed: () {
                      Get.toNamed(WebRoutes.addPostTutor);
                    },
                    enableIcon: true,
                    loading: false),
                ButtonIcon(
                    icon: Icons.person,
                    onPressed: () {
                      Get.toNamed(WebRoutes.userFriendsPage);
                    },
                    enableIcon: true,
                    label: 'Friends',
                    loading: false),
                ButtonIcon(
                    icon: Icons.photo_size_select_actual_rounded,
                    onPressed: () {
                      Get.toNamed(WebRoutes.userPostPage);
                    },
                    label: 'Posts',
                    enableIcon: true,
                    loading: false),
              ],
            ),
            const Gap(15),
            SizedBox(
              height: screenSize.height * 0.4,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(
                        color: Colors.grey.shade500.withAlpha(150),
                        thickness: 0.5,
                        height: 0.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TutorProfileInfo(
                            info: _userStaticsController.userLocation,
                            icon: Icons.home,
                          ),
                          const Gap(15),
                          TutorProfileInfo(
                            info: _userStaticsController.userEmail,
                            icon: Icons.email,
                          ),
                          const Gap(15),
                          TutorProfileInfo(
                            info: _userStaticsController.userPhoneNumber,
                            icon: Icons.phone,
                          ),
                          const Gap(15),
                          TutorProfileInfo(
                            info: _userStaticsController.tutor!.profession
                                .toString()
                                .split('.')
                                .last
                                .replaceAll('_', ' '),
                            icon: Icons.cases_outlined,
                          ),
                          const Gap(20),
                          TutorProfileInfo(
                            info: _userStaticsController.userEducation,
                            icon: Icons.school,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*                                        Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonIcon(
                          label: 'Messege',
                          icon: Icons.message,
                          onPressed: () {},
                          enableIcon: true,
                          loading: false,
                        ),
                        ButtonIcon(
                          label: 'Connect',
                          icon: Icons.person_add_alt,
                          onPressed: () {},
                          enableIcon: true,
                          loading: false,
                        ),
                      ],
                    ), */