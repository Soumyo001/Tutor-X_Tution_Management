import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/controllers/report_controller.dart';
import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/pages/main_pages/home_page.dart';
import 'package:tutor_x_tution_management/service/api/report_api.dart';
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
  late final ReportController _reportController;

  Future<void> getUserData() async {
    final currentUser = AuthService.fromFirebase().currentUser;
    if (currentUser != null) {
      final user = await UserApi().getUserByEmail(currentUser.email!);
      await _reportController.loadReportCount(user.first.userId);
      final report = await ReportApi().getReportByUidTo(user.first.userId);

      user.first.userReports = report.length;
      await UserApi()
          .updateUser(userId: user.first.userId, body: user.first.toJson());

      if (_reportController.reportCount < report.length) {
        _reportController.reportCount = report.length;
        _reportController.hasReported = false;

        await _reportController.saveReportCount(
          _reportController.reportCount,
          _reportController.hasReported,
          user.first.userId,
        );
      }

      if (user.isNotEmpty) {
        _userStaticsController.userId = user.first.userId;
        _userStaticsController.userCategory = user.first.userType;
        _userStaticsController.userName = user.first.fullName;
        _userStaticsController.userEmail = user.first.email;
        _userStaticsController.userEducation = user.first.education;
        _userStaticsController.userLocation = user.first.location;
        _userStaticsController.userPhoneNumber = user.first.phoneNumber;
        _userStaticsController.userReports = user.first.userReports;
        dev.log('MESSEGE: Inside User Data');
        switch (user.first.userType) {
          case UserCategory.teacher:
            final t = await TutorApi().getTutorByUserId(user.first.userId);

            if (t.isNotEmpty) {
              final teacher = t.first;
              dev.log('MESSEGE: Inside teacher : ${teacher.imageData}');
              _userStaticsController.tutor = teacher;
              _userStaticsController.tutorSalary = teacher.expectedSalary;
              _userStaticsController.tutorAvailabilityStatus = teacher.status;
              _userStaticsController.tutorProfessionType = teacher.profession;
              _userStaticsController.tutorSelfDesc =
                  teacher.tutorSelfDescription;
              _userStaticsController.tutorStudentMedium =
                  teacher.mediumOfInterest;
              _userStaticsController.tutorStudentType = teacher.expectedStudent;
              _userStaticsController.tutorSubjectType =
                  teacher.subjectOfInterest;
              _userStaticsController.tutorVerificationStatus =
                  teacher.verificationStatus;

              if (teacher.imageData != null) {
                _userStaticsController.imageData =
                    base64Decode(teacher.imageData!);
                dev.log(
                    'MESSEGE: Inside teacher image data : ${Get.find<UserStaticsController>().imageData}');
              }
            }
            break;
          case UserCategory.student:
            final student =
                await StudentApi().getStudentByUserId(user.first.userId);
            if (student.isNotEmpty) {
              final s = student.first;
              dev.log('MESSEGE: Inside student : ${s.imageData}');
              _userStaticsController.student = s;
              _userStaticsController.studentMedium = s.studentMedium;
              _userStaticsController.studentSelfDesc = s.studentSelfDescription;

              if (s.imageData != null) {
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
    _reportController = Get.find<ReportController>();
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
