import 'dart:convert';

import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tutor_x_tution_management/utils/color_pallete.dart';
import 'package:tutor_x_tution_management/components/tutor_display_widget.dart';
import 'package:tutor_x_tution_management/models/student.dart';
import 'package:tutor_x_tution_management/models/user.dart';
import 'package:tutor_x_tution_management/service/api/student_api.dart';
import 'package:tutor_x_tution_management/service/api/tutor_api.dart';
import 'dart:developer' as dev;

import 'package:tutor_x_tution_management/service/api/user_api.dart';

class RecentStudentDisplay extends StatefulWidget {
  const RecentStudentDisplay({super.key});

  @override
  State<RecentStudentDisplay> createState() => _RecentStudentDisplayState();
}

class _RecentStudentDisplayState extends State<RecentStudentDisplay> {
  Uint8List? _imageData;

  Future<void> _pickImage(List<Student> students, int index) async {
    if (kIsWeb) {
      try {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          final f = await image.readAsBytes();
          setState(() {
            _imageData = f;
            students[index].imageData = base64Encode(_imageData!);
          });
          await TutorApi().updateTutor(
            tutorId: students[index].studentId,
            body: students[index].toJson(),
          );
          dev.log(base64Encode(_imageData!));
        }
      } catch (e) {
        dev.log(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: (650 / 945) * screenSize.height,
      width: 1000,
      child: FutureBuilder(
        future: StudentApi().getAllStudent(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final students = snapshot.data as List<Student>;
              return students.isEmpty
                  ? Center(
                      child: Text(
                        'No Students are registered at the moment'
                            .toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 3,
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: screenSize.width < 800 ? 2 : 3),
                      itemCount: students.length >= 6 ? 6 : students.length,
                      itemBuilder: (context, index) {
                        final student = students[students.length -
                            (students.length >= 6 ? 6 : students.length) +
                            index];
                        return FutureBuilder(
                          future: UserApi().getUserById(student.userId),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.done:
                                final userData = snapshot.data as User;
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.withAlpha(150)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withAlpha(50),
                                            border: Border(
                                              bottom: BorderSide(
                                                color:
                                                    Colors.grey.withAlpha(150),
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TutorDisplayWidget(
                                                text:
                                                    '${student.firstName} ${student.lastName}',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                fontColor: Colors.black87,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Gap(13),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: TutorDisplayWidget(
                                                  text:
                                                      'Name: ${student.firstName} ${student.lastName}',
                                                  fontSize: 15,
                                                  fontColor:
                                                      Colors.grey.shade600,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: TutorDisplayWidget(
                                                  text:
                                                      'Education: ${userData.education}',
                                                  fontSize: 15,
                                                  fontColor:
                                                      Colors.grey.shade600,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: TutorDisplayWidget(
                                                  text:
                                                      'Location: ${userData.location}',
                                                  fontSize: 15,
                                                  fontColor:
                                                      Colors.grey.shade600,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: TutorDisplayWidget(
                                                  text:
                                                      'Medium: ${student.studentMedium.toString().split('.').last}',
                                                  fontSize: 15,
                                                  fontColor:
                                                      Colors.grey.shade600,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withAlpha(50),
                                            border: Border(
                                              top: BorderSide(
                                                  color: Colors.grey
                                                      .withAlpha(150)),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              MaterialButton(
                                                onPressed: () async {
                                                  await _pickImage(
                                                      students, index);
                                                },
                                                padding:
                                                    const EdgeInsets.all(16),
                                                color: Pallete.buttonColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    3,
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Learn More',
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
                              default:
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                            }
                          },
                        );
                      },
                    );

            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}
