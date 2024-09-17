import 'dart:convert';

import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/color_pallete.dart';
import 'package:tutor_x_tution_management/components/tutor_display_widget.dart';
import 'package:tutor_x_tution_management/controllers/filter_controller.dart';
import 'package:tutor_x_tution_management/models/tutor.dart';
import 'package:tutor_x_tution_management/models/tutor_post.dart';
import 'package:tutor_x_tution_management/routes/route.dart';
import 'package:tutor_x_tution_management/service/api/tutor_api.dart';
import 'package:tutor_x_tution_management/service/api/tutor_post_api.dart';

class RecentTutorPost extends StatefulWidget {
  final bool hasLimit;
  const RecentTutorPost({super.key, required this.hasLimit});

  @override
  State<RecentTutorPost> createState() => _RecentTutorPostState();
}

class _RecentTutorPostState extends State<RecentTutorPost> {
  late final FilterController _filterController;

  @override
  void initState() {
    super.initState();
    _filterController = Get.find<FilterController>();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: 0.45 * screenSize.height,
      width: screenSize.width * 0.5,
      child: FutureBuilder(
        future:
            TutorPostApi().getTutorPostsByFilter(null, null, null, null, null),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _filterController.tutorPosts = snapshot.data as List<TutorPost>;
            });
            return Obx(
              () => _filterController.tutorPosts.isEmpty
                  ? Center(
                      child: Text(
                        'It\'s quiet right now...'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 3,
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: screenSize.width < 800 ? 2 : 3),
                      itemCount: widget.hasLimit
                          ? _filterController.tutorPosts.length >= 3
                              ? 3
                              : _filterController.tutorPosts.length
                          : _filterController.tutorPosts.length,
                      itemBuilder: (context, index) {
                        final tutorPost = _filterController.tutorPosts[widget
                                .hasLimit
                            ? _filterController.tutorPosts.length >= 3
                                ? (index +
                                    (_filterController.tutorPosts.length - 3))
                                : index
                            : index];
                        return FutureBuilder(
                          future: TutorApi().getTutorById(tutorPost.tutorId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              final tutor = snapshot.data as Tutor;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  height: 300,
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      tutor.imageData != null
                                          ? Image.memory(
                                              base64Decode(tutor.imageData!),
                                              height: 120,
                                              width: 300,
                                              fit: BoxFit.fitWidth)
                                          : Image.asset(
                                              'lib/assets/images/profile_placeholder.jpg',
                                              height: 120,
                                              width: 300,
                                              fit: BoxFit.fitWidth,
                                            ),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TutorDisplayWidget(
                                            text: tutorPost.fullName,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ],
                                      ),
                                      const Gap(13),
                                      TutorDisplayWidget(
                                        text:
                                            'Status: ${tutor.status.toString().split('.').last}',
                                      ),
                                      const Gap(2),
                                      TutorDisplayWidget(
                                        text: 'Bio: ${tutorPost.bio}',
                                      ),
                                      const Gap(2),
                                      TutorDisplayWidget(
                                        text:
                                            'interested: ${tutorPost.subjectOfInterest.toString().split('.').last.replaceAll('_', ' ')}',
                                      ),
                                      const Gap(2),
                                      TutorDisplayWidget(
                                        text:
                                            'Class: ${tutorPost.expectedStudent.toString().split('.').last.replaceAll('_', ' ').replaceAll('to', '-')}',
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            MaterialButton(
                                              onPressed: () {
                                                Get.toNamed(
                                                  WebRoutes.postView,
                                                  arguments: {
                                                    "tutor_post": tutorPost
                                                  },
                                                );
                                              },
                                              padding: const EdgeInsets.all(16),
                                              color: Pallete.buttonColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  3,
                                                ),
                                              ),
                                              child: const Text(
                                                'Read More',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        );
                      },
                    ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
