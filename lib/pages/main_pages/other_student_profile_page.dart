import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/models/student.dart';
import 'package:tutor_x_tution_management/models/user.dart';
import 'package:tutor_x_tution_management/pages/views/profile_views/other_student_profile_views/other_student_profile_view_left.dart';
import 'package:tutor_x_tution_management/pages/views/profile_views/other_student_profile_views/other_student_profile_view_right.dart';

class ProfilePageOtherStudent extends StatefulWidget {
  const ProfilePageOtherStudent({super.key});

  @override
  State<ProfilePageOtherStudent> createState() =>
      _ProfilePageOtherStudentState();
}

class _ProfilePageOtherStudentState extends State<ProfilePageOtherStudent> {
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final otherStudent = args['student_data'] as Student;
    final otherUser = args['user_data'] as User;
    return Scaffold(
      body: Row(
        children: [
          OtherStudentProfileViewPartLeft(
              student: otherStudent, user: otherUser),
          OtherStudentProfileViewPartRight(
              student: otherStudent, user: otherUser),
        ],
      ),
    );
  }
}
