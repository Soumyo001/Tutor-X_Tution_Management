import 'package:flutter/material.dart';
import 'package:tutor_x_tution_management/pages/views/profile_views/student_profile_views/student_profile_view_part_left.dart';
import 'package:tutor_x_tution_management/pages/views/profile_views/student_profile_views/student_profile_view_part_right.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({super.key});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          StudentProfileViewLeft(),
          StudentProfileViewRight(),
        ],
      ),
    );
  }
}
