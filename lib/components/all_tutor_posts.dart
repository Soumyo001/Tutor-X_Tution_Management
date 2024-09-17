import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/components/tutor_post_display.dart';
import 'package:tutor_x_tution_management/controllers/user_post_controller.dart';
import 'package:tutor_x_tution_management/models/tutor.dart';
import 'package:tutor_x_tution_management/models/tutor_post.dart';
import 'package:tutor_x_tution_management/service/api/tutor_api.dart';
import 'package:tutor_x_tution_management/service/api/tutor_post_api.dart';

class TutorPosts extends StatefulWidget {
  final int uid;
  const TutorPosts({super.key, required this.uid});

  @override
  State<TutorPosts> createState() => _TutorPostsState();
}

class _TutorPostsState extends State<TutorPosts> {
  late final UserPostController _userPostController;

  @override
  void initState() {
    super.initState();
    _userPostController = Get.find<UserPostController>();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TutorApi().getTutorByUserId(widget.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final tut = snapshot.data as List<Tutor>;
          return FutureBuilder(
            future: TutorPostApi().getTutorPostsByFilter(
                tut.first.tutorId, null, null, null, null),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Obx(
                  () {
                    _userPostController.tutorPosts =
                        snapshot.data as List<TutorPost>;
                    if (_userPostController.tutorPosts.isNotEmpty) {
                      return Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          primary: true,
                          itemCount: _userPostController.tutorPosts.length,
                          itemBuilder: (context, index) {
                            final post = _userPostController.tutorPosts[index];
                            return TutorPostDisplay(
                              tutor: tut.first,
                              tutorPost: post,
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
