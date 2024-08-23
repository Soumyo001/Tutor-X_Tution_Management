import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tutor_x_tution_management/components/post_view_profile_tap.dart';
import 'package:tutor_x_tution_management/components/tutor_display_widget.dart';
import 'package:tutor_x_tution_management/models/student.dart';
import 'package:tutor_x_tution_management/models/student_post.dart';
import 'package:tutor_x_tution_management/service/api/student_api.dart';

class StudentPostView extends StatefulWidget {
  final StudentPost? studentPost;
  const StudentPostView({super.key, this.studentPost});

  @override
  State<StudentPostView> createState() => _StudentPostViewState();
}

class _StudentPostViewState extends State<StudentPostView> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: FutureBuilder(
          future: StudentApi().getStudentById(widget.studentPost!.studentId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final student = snapshot.data as Student;
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
                          imageData: student.imageData,
                          fullName: widget.studentPost!.fullName,
                          userId: student.userId,
                        ),
                      ],
                    ),
                    const Gap(20),
                    TutorDisplayWidget(
                      text: 'Education: ${widget.studentPost!.education}',
                      fontSize: 19,
                    ),
                    const Gap(2),
                    TutorDisplayWidget(
                      text: 'Location: ${widget.studentPost!.location}',
                      fontSize: 19,
                    ),
                    const Gap(2),
                    TutorDisplayWidget(
                      text:
                          'Day: ${widget.studentPost!.days.toString().split('.').last.replaceAll('_', ' ')}',
                      fontSize: 19,
                    ),
                    const Gap(2),
                    TutorDisplayWidget(
                      text: 'Salary: ${widget.studentPost!.salary.toString()}',
                      fontSize: 19,
                    ),
                    const Gap(2),
                    TutorDisplayWidget(
                      text:
                          'Medium: ${widget.studentPost!.studentMedium.toString().split('.').last.replaceAll('_', ' ')}',
                      fontSize: 19,
                    ),
                    const Gap(2),
                    TutorDisplayWidget(
                      text:
                          'Subject: ${widget.studentPost!.subjectTypes.toString().split('.').last.replaceAll('_', ' ')}',
                      fontSize: 19,
                    ),
                    const Gap(25),
                    const TutorDisplayWidget(
                      text: 'Description :',
                      fontSize: 17,
                    ),
                    const Gap(10),
                    TutorDisplayWidget(
                      text: widget.studentPost!.studentDes,
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
