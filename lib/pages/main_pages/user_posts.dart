import 'package:flutter/Material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/components/all_student_posts.dart';
import 'package:tutor_x_tution_management/components/all_tutor_posts.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'package:tutor_x_tution_management/data/enums.dart';

class UserPosts extends StatefulWidget {
  const UserPosts({super.key});

  @override
  State<UserPosts> createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
  late final UserStaticsController _userStaticsController;

  @override
  void initState() {
    super.initState();
    _userStaticsController = Get.find<UserStaticsController>();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Posts',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black87,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Divider(
                color: Colors.grey.shade400,
                height: 0.5,
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.85,
              child:
                  (_userStaticsController.userCategory == UserCategory.teacher
                      ? TutorPosts(uid: _userStaticsController.userId)
                      : StudentPosts(uid: _userStaticsController.userId)),
            ),
          ],
        ),
      ),
    );
  }
}
