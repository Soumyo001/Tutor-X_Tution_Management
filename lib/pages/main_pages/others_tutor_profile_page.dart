import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/pages/views/profile_views/other_tutor_profile_views/other_tutor_profile_view_left.dart';
import 'package:tutor_x_tution_management/pages/views/profile_views/other_tutor_profile_views/other_tutor_profile_view_right.dart';
import 'package:tutor_x_tution_management/models/tutor.dart';
import 'package:tutor_x_tution_management/models/user.dart';

class ProfilePageOtherTutor extends StatefulWidget {
  const ProfilePageOtherTutor({super.key});

  @override
  State<ProfilePageOtherTutor> createState() => _ProfilePageOtherTutorState();
}

class _ProfilePageOtherTutorState extends State<ProfilePageOtherTutor> {
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final otherTutor = args['tutor_data'] as Tutor;
    final otherUser = args['user_data'] as User;
    return Scaffold(
      body: Row(
        children: [
          OtherTutorProfileViewPartLeft(tutor: otherTutor, user: otherUser),
          OtherTutorProfileViewPartRight(tutor: otherTutor, user: otherUser),
        ],
      ),
    );
  }
}
