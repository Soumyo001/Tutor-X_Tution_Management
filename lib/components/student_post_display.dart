// ignore_for_file: use_build_context_synchronously

import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/components/just_icon.dart';
import 'package:tutor_x_tution_management/components/post_view_profile_tap.dart';
import 'package:tutor_x_tution_management/components/tutor_display_widget.dart';
import 'package:tutor_x_tution_management/controllers/user_post_controller.dart';
import 'package:tutor_x_tution_management/models/student.dart';
import 'package:tutor_x_tution_management/models/student_post.dart';
import 'package:tutor_x_tution_management/service/api/student_post_api.dart';
import 'package:tutor_x_tution_management/utils/dialogs/confirmation_dialog.dart';
import 'package:tutor_x_tution_management/utils/dialogs/error_dialog.dart';

class StudentPostDisplay extends StatefulWidget {
  final Student student;
  final StudentPost studentPost;
  final int uid;
  const StudentPostDisplay({
    super.key,
    required this.student,
    required this.studentPost,
    required this.uid,
  });

  @override
  State<StudentPostDisplay> createState() => _StudentPostDisplayState();
}

class _StudentPostDisplayState extends State<StudentPostDisplay> {
  late final UserPostController _userPostController;
  @override
  void initState() {
    super.initState();
    _userPostController = Get.find<UserPostController>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PostViewProfileHolder(
                  imageData: widget.student.imageData,
                  fullName: widget.studentPost.fullName,
                  userId: widget.uid,
                  tappable: false,
                ),
                JustIcon(
                  icon: Icons.delete_forever_outlined,
                  onPressed: () async {
                    final sure = await showConfirmationDialog(
                      context,
                      'Do you want to delete this post ?',
                      acceptString: 'Yes',
                      declineString: 'No',
                    );
                    if (sure) {
                      final response = await StudentPostApi()
                          .deleteStudentPost(widget.studentPost.studentPostId);
                      if (!(response.statusCode >= 200 &&
                          response.statusCode <= 299)) {
                        await showErrorDialog(
                            context, 'There was an error deleting your post');
                      } else {
                        _userPostController.studentPosts.removeWhere(
                            (element) =>
                                element.studentPostId ==
                                widget.studentPost.studentPostId);
                      }
                    }
                  },
                ),
              ],
            ),
            TutorDisplayWidget(
              text: 'Education: ${widget.studentPost.education}',
              fontSize: 19,
              maxWidth: 370,
            ),
            TutorDisplayWidget(
              text:
                  'Location: ${widget.studentPost.location.toString().split('.').last.replaceAll('_', ' ')}',
              fontSize: 19,
              maxWidth: 370,
            ),
            TutorDisplayWidget(
              text:
                  'Day: ${widget.studentPost.days.toString().split('.').last.replaceAll('_', ' ').replaceAll('to', '-')}',
              fontSize: 19,
              maxWidth: 370,
            ),
            TutorDisplayWidget(
              text: 'Salary : ${widget.studentPost.salary.toString()}',
              fontSize: 19,
              maxWidth: 370,
            ),
            TutorDisplayWidget(
              text:
                  'Medium : ${widget.studentPost.studentMedium.toString().split('.').last.replaceAll('_', ' ').replaceAll('to', '-')}',
              fontSize: 19,
              maxWidth: 370,
            ),
            TutorDisplayWidget(
              text:
                  'Subject : ${widget.studentPost.subjectTypes.toString().split('.').last.replaceAll('_', ' ').replaceAll('to', '-')}',
              fontSize: 19,
              maxWidth: 370,
            ),
            TutorDisplayWidget(
              text: 'Description : ${widget.studentPost.studentDes}',
              fontSize: 17,
              maxWidth: 370,
            ),
          ],
        ),
      ),
    );
  }
}
