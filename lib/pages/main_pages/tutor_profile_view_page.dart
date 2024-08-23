import 'package:flutter/material.dart';
import 'package:tutor_x_tution_management/pages/views/profile_views/tutor_profile_views/tutor_profile_view_part_left.dart';
import 'package:tutor_x_tution_management/pages/views/profile_views/tutor_profile_views/tutor_profile_view_right_part.dart';

class TutorProfileViewPage extends StatefulWidget {
  const TutorProfileViewPage({super.key});

  @override
  State<TutorProfileViewPage> createState() => _TutorProfileViewPageState();
}

class _TutorProfileViewPageState extends State<TutorProfileViewPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          TutorProfileViewLeftPart(),
          TutorProfileViewRightPart(),
        ],
      ),
    );
  }
}
