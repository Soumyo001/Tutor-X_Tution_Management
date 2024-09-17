import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/components/student_post_display.dart';
import 'package:tutor_x_tution_management/controllers/user_post_controller.dart';
import 'package:tutor_x_tution_management/models/student.dart';
import 'package:tutor_x_tution_management/models/student_post.dart';
import 'package:tutor_x_tution_management/service/api/student_api.dart';
import 'package:tutor_x_tution_management/service/api/student_post_api.dart';

class StudentPosts extends StatefulWidget {
  final int uid;
  const StudentPosts({super.key, required this.uid});

  @override
  State<StudentPosts> createState() => _StudentPostsState();
}

class _StudentPostsState extends State<StudentPosts> {
  late final UserPostController _userPostController;

  @override
  void initState() {
    super.initState();
    _userPostController = Get.find<UserPostController>();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StudentApi().getStudentByUserId(widget.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final stu = snapshot.data as List<Student>;
          return FutureBuilder(
            future: StudentPostApi().getStudentPostsByFilter(
                stu.first.studentId, null, null, null, null),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Obx(
                  () {
                    _userPostController.studentPosts =
                        snapshot.data as List<StudentPost>;
                    if (_userPostController.studentPosts.isNotEmpty) {
                      return Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: _userPostController.studentPosts.length,
                          itemBuilder: (context, index) {
                            final post =
                                _userPostController.studentPosts[index];
                            return StudentPostDisplay(
                              student: stu.first,
                              studentPost: post,
                              uid: widget.uid,
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          'You currently don\'t have any post...'.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 3,
                          ),
                        ),
                      );
                    }
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
