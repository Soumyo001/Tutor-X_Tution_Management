// ignore_for_file: use_build_context_synchronously

import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/components/just_icon.dart';
import 'package:tutor_x_tution_management/components/post_view_profile_tap.dart';
import 'package:tutor_x_tution_management/components/tutor_display_widget.dart';
import 'package:tutor_x_tution_management/controllers/user_post_controller.dart';
import 'package:tutor_x_tution_management/models/tutor.dart';
import 'package:tutor_x_tution_management/models/tutor_post.dart';
import 'package:tutor_x_tution_management/service/api/tutor_post_api.dart';
import 'package:tutor_x_tution_management/utils/dialogs/confirmation_dialog.dart';
import 'package:tutor_x_tution_management/utils/dialogs/error_dialog.dart';

class TutorPostDisplay extends StatefulWidget {
  final Tutor tutor;
  final TutorPost tutorPost;
  final int uid;
  const TutorPostDisplay({
    super.key,
    required this.tutor,
    required this.tutorPost,
    required this.uid,
  });

  @override
  State<TutorPostDisplay> createState() => _TutorPostDisplayState();
}

class _TutorPostDisplayState extends State<TutorPostDisplay> {
  late final UserPostController _userPostController;
  @override
  void initState() {
    super.initState();
    _userPostController = Get.find<UserPostController>();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: screenSize.height * 0.23,
        width: screenSize.width * 0.5,
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
                  imageData: widget.tutor.imageData,
                  fullName: widget.tutorPost.fullName,
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
                      final response = await TutorPostApi()
                          .deleteTutorPost(widget.tutorPost.tutorPostId);
                      if (!(response.statusCode >= 200 &&
                          response.statusCode <= 299)) {
                        await showErrorDialog(
                            context, 'There was an error deleting your post');
                      } else {
                        _userPostController.tutorPosts.removeWhere((element) =>
                            element.tutorPostId ==
                            widget.tutorPost.tutorPostId);
                      }
                    }
                  },
                ),
              ],
            ),
            TutorDisplayWidget(
              text: 'Bio: ${widget.tutorPost.bio}',
              fontSize: 19,
              maxWidth: 370,
            ),
            TutorDisplayWidget(
              text:
                  'interested: ${widget.tutorPost.subjectOfInterest.toString().split('.').last.replaceAll('_', ' ')}',
              fontSize: 19,
              maxWidth: 370,
            ),
            TutorDisplayWidget(
              text:
                  'Class: ${widget.tutorPost.expectedStudent.toString().split('.').last.replaceAll('_', ' ').replaceAll('to', '-')}',
              fontSize: 19,
              maxWidth: 370,
            ),
            TutorDisplayWidget(
              text: 'Description : ${widget.tutorPost.tutorDes}',
              fontSize: 17,
              maxWidth: 370,
            ),
          ],
        ),
      ),
    );
  }
}
