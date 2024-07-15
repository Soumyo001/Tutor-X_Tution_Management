import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/pages/main_pages/home_page.dart';
import 'package:tutor_x_tution_management/service/api/student_api.dart';
import 'package:tutor_x_tution_management/service/api/tutor_api.dart';
import 'package:tutor_x_tution_management/service/api/user_api.dart';
import 'package:tutor_x_tution_management/service/auth/auth_service.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'dart:developer' as dev;

class PreInfoPage extends StatefulWidget {
  const PreInfoPage({super.key});

  @override
  State<PreInfoPage> createState() => _PreInfoPageState();
}

class _PreInfoPageState extends State<PreInfoPage> {
  late final UserStaticsController _userStaticsController;

  Future<void> getUserData() async {
    final currentUser = AuthService.fromFirebase().currentUser;
    if (currentUser != null) {
      final user = await UserApi().getUserByEmail(currentUser.email!);
      if (user.isNotEmpty) {
        _userStaticsController.userCategory = user.first.userType;
        _userStaticsController.userName = user.first.fullName;
        _userStaticsController.userEmail = user.first.email;
        _userStaticsController.userEducation = user.first.education;
        _userStaticsController.userEducation = user.first.location;
        _userStaticsController.userPhoneNumber = user.first.phoneNumber;
        dev.log('MESSEGE: Inside User Data');
        switch (user.first.userType) {
          case UserCategory.teacher:
            final teacher =
                await TutorApi().getTutorByUserId(user.first.userId);
            if (teacher.isNotEmpty) {
              dev.log('MESSEGE: Inside teacher : ${teacher.first.imageData}');
              if (teacher.first.imageData != null) {
                _userStaticsController.imageData =
                    base64Decode(teacher.first.imageData!);
                dev.log(
                    'MESSEGE: Inside teacher image data : ${Get.find<UserStaticsController>().imageData}');
              }
            }
            break;
          case UserCategory.student:
            final student =
                await StudentApi().getStudentByUserId(user.first.userId);
            if (student.isNotEmpty) {
              dev.log('MESSEGE: Inside student : ${student.first.imageData}');
              if (student.first.imageData != null) {
                _userStaticsController.imageData =
                    base64Decode(student.first.imageData!);
                dev.log(
                    'MESSEGE: Inside student image data : ${Get.find<UserStaticsController>().imageData}');
              }
            }
            break;
          default:
            break;
        }
      } else {
        _userStaticsController.userName = 'Shifat jaman';
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _userStaticsController = Get.find<UserStaticsController>();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print('AGAIN CALLED PRE INFO !!!!!!');
          return const HomePage();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
