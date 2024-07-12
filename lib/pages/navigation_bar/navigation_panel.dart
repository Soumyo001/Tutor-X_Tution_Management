import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/color_pallete.dart';
import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/pages/navigation_bar/nav_build_entry.dart';
import 'package:tutor_x_tution_management/service/api/student_api.dart';
import 'package:tutor_x_tution_management/service/api/tutor_api.dart';
import 'package:tutor_x_tution_management/service/api/user_api.dart';
import 'package:tutor_x_tution_management/service/auth/auth_service.dart';

class NavigationPanel extends StatefulWidget {
  const NavigationPanel({
    super.key,
  });

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  RxBool isMainPageHovered = false.obs;
  RxBool isProfileTapped = false.obs;
  RxString userName = "".obs;
  Uint8List? _imageData;

  void getUsername() async {
    final currentUser = AuthService.fromFirebase().currentUser;
    if (currentUser != null) {
      final user = await UserApi().getUserByEmail(currentUser.email!);
      if (user.isNotEmpty) {
        userName.value = user.first.fullName;
        switch (user.first.userType) {
          case UserCategory.teacher:
            final teacher =
                await TutorApi().getTutorByUserId(user.first.userId);
            if (teacher.isNotEmpty) {
              if (teacher.first.imageData != null) {
                setState(() {
                  _imageData = base64Decode(teacher.first.imageData!);
                });
              }
            }
            break;
          case UserCategory.student:
            final student =
                await StudentApi().getStudentByUserId(user.first.userId);
            if (student.isNotEmpty) {
              if (student.first.imageData != null) {
                setState(() {
                  _imageData = base64Decode(student.first.imageData!);
                });
              }
            }
            break;
          default:
            break;
        }
      } else {
        userName.value = 'Shifat jaman';
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Pallete.gradiant9.withAlpha(200),
            Pallete.gradiant9.withAlpha(160),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onHover: (value) {
              isMainPageHovered.value = value;
            },
            onTap: () {},
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(
                      'lib/assets/icons/logo.png',
                    ),
                  ),
                  const Gap(7),
                  Obx(
                    () => Text(
                      'Tutor-X:Tution Management',
                      style: TextStyle(
                        letterSpacing: 3,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: isMainPageHovered.value
                            ? Colors.white38
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onHover: (value) {
                    isProfileTapped.value = value;
                  },
                  onTap: () {},
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: [
                        const Gap(7),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundImage: _imageData != null
                                  ? MemoryImage(_imageData!)
                                  : null,
                              child: _imageData == null
                                  ? const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'lib/assets/images/person.jpg'),
                                    )
                                  : null,
                            ),
                            const Gap(7),
                            Obx(
                              () => Text(
                                userName.value,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: isProfileTapped.value
                                      ? Colors.black38
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(5),
                const VerticalDivider(
                  color: Colors.black,
                  thickness: 1,
                ),
                const Gap(5),
                const NavBuildEntry(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
