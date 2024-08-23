import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/routes/route.dart';
import 'package:tutor_x_tution_management/service/api/student_api.dart';
import 'package:tutor_x_tution_management/service/api/tutor_api.dart';
import 'package:tutor_x_tution_management/service/api/user_api.dart';

class PostViewProfileHolder extends StatefulWidget {
  final String? imageData;
  final String fullName;
  final int userId;
  const PostViewProfileHolder({
    super.key,
    required this.imageData,
    required this.fullName,
    required this.userId,
  });

  @override
  State<PostViewProfileHolder> createState() => _PostViewProfileHolderState();
}

class _PostViewProfileHolderState extends State<PostViewProfileHolder> {
  final RxBool isProfileHovered = false.obs;
  late final UserStaticsController _userStaticsController;

  @override
  void initState() {
    super.initState();
    _userStaticsController = Get.find<UserStaticsController>();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        isProfileHovered.value = value;
      },
      onTap: () async {
        if (_userStaticsController.userId == widget.userId) {
          if (_userStaticsController.userCategory == UserCategory.teacher) {
            Get.toNamed(WebRoutes.tutorProfilePage);
          } else {
            Get.toNamed(WebRoutes.studentProfilePage);
          }
        } else {
          final user = await UserApi().getUserById(widget.userId);
          if (user!.userType == UserCategory.teacher) {
            final tutor = await TutorApi().getTutorByUserId(user.userId);
            Get.toNamed(
              WebRoutes.otherTutorProfilePage,
              arguments: {'tutor_data': tutor.first, 'user_data': user},
            );
          } else {
            final student = await StudentApi().getStudentByUserId(user.userId);
            Get.toNamed(
              WebRoutes.otherStudentProfilePage,
              arguments: {'student_data': student.first, 'user_data': user},
            );
          }
        }
      },
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
                  backgroundImage: widget.imageData != null
                      ? MemoryImage(base64Decode(widget.imageData!))
                      : null,
                  child: widget.imageData == null
                      ? const Icon(Icons.person)
                      : null,
                ),
                const Gap(5),
                Obx(
                  () => Text(
                    widget.fullName,
                    style: TextStyle(
                      fontSize: 17,
                      decoration: isProfileHovered.value
                          ? TextDecoration.underline
                          : null,
                      color: isProfileHovered.value
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
    );
  }
}
