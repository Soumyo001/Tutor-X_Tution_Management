import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tutor_x_tution_management/components/post_view_profile_tap.dart';
import 'package:tutor_x_tution_management/components/tutor_display_widget.dart';
import 'package:tutor_x_tution_management/models/tutor.dart';
import 'package:tutor_x_tution_management/models/tutor_post.dart';
import 'package:tutor_x_tution_management/service/api/tutor_api.dart';

class TutorPostView extends StatefulWidget {
  final TutorPost? tutorPost;
  const TutorPostView({super.key, this.tutorPost});

  @override
  State<TutorPostView> createState() => _TutorPostViewState();
}

class _TutorPostViewState extends State<TutorPostView> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: FutureBuilder(
          future: TutorApi().getTutorById(widget.tutorPost!.tutorId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final tutor = snapshot.data as Tutor;
              return Container(
                width: screenSize.width * 0.5,
                height: screenSize.height * 0.5,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        PostViewProfileHolder(
                          imageData: tutor.imageData,
                          fullName: widget.tutorPost!.fullName,
                          userId: tutor.userId,
                        ),
                      ],
                    ),
                    const Gap(20),
                    TutorDisplayWidget(
                      text:
                          'Status: ${tutor.status.toString().split('.').last}',
                      fontSize: 19,
                    ),
                    const Gap(2),
                    TutorDisplayWidget(
                      text: 'Bio: ${widget.tutorPost!.bio}',
                      fontSize: 19,
                    ),
                    const Gap(2),
                    TutorDisplayWidget(
                      text:
                          'interested: ${widget.tutorPost!.subjectOfInterest.toString().split('.').last.replaceAll('_', ' ')}',
                      fontSize: 19,
                    ),
                    const Gap(2),
                    TutorDisplayWidget(
                      text:
                          'Class: ${widget.tutorPost!.expectedStudent.toString().split('.').last.replaceAll('_', ' ').replaceAll('to', '-')}',
                      fontSize: 19,
                    ),
                    const Gap(25),
                    const TutorDisplayWidget(
                      text: 'Description :',
                      fontSize: 17,
                    ),
                    const Gap(10),
                    TutorDisplayWidget(
                      text: widget.tutorPost!.tutorDes,
                      fontSize: 17,
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
