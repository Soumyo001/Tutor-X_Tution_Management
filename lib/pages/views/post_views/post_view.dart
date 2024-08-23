import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/models/student_post.dart';
import 'package:tutor_x_tution_management/models/tutor_post.dart';
import 'package:tutor_x_tution_management/pages/views/post_views/student_post_view.dart';
import 'package:tutor_x_tution_management/pages/views/post_views/tutor_post_veiw.dart';

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final tutorPost = arguments["tutor_post"] as TutorPost?;
    final studentPost = arguments["student_post"] as StudentPost?;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: (tutorPost != null
          ? TutorPostView(tutorPost: tutorPost)
          : StudentPostView(studentPost: studentPost)),
    );
  }
}
