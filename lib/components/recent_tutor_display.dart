import 'dart:convert';

import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tutor_x_tution_management/color_pallete.dart';
import 'package:tutor_x_tution_management/components/tutor_display_widget.dart';
import 'package:tutor_x_tution_management/models/tutor.dart';
import 'package:tutor_x_tution_management/models/user.dart';
import 'package:tutor_x_tution_management/service/api/tutor_api.dart';
import 'package:tutor_x_tution_management/service/api/user_api.dart';
import 'dart:developer' as dev;

class RecentTutorsDisplay extends StatefulWidget {
  const RecentTutorsDisplay({super.key});

  @override
  State<RecentTutorsDisplay> createState() => _RecentTutorsDisplayState();
}

class _RecentTutorsDisplayState extends State<RecentTutorsDisplay> {
  Uint8List? _imageData;

  Future<void> _pickImage(Tutor tutor) async {
    if (kIsWeb) {
      try {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          final f = await image.readAsBytes();
          setState(() {
            _imageData = f;
            tutor.imageData = base64Encode(_imageData!);
          });
          await TutorApi().updateTutor(
            tutorId: tutor.tutorId,
            body: tutor.toJson(),
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
      height: (300 / 945) * screenSize.height,
      child: FutureBuilder(
        future: TutorApi().getAllTutor(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final tutors = snapshot.data as List<Tutor>;
              return tutors.isEmpty
                  ? Center(
                      child: Text(
                        'No Tutors registered at the moment'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 3,
                        ),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: screenSize.width < 800 ? 2 : 4,
                      itemBuilder: (context, index) {
                        final tutor = tutors[tutors.length -
                            (screenSize.width < 800 ? 2 : 4) +
                            index];
                        return FutureBuilder(
                          future: UserApi().getUserById(tutor.userId),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.done:
                                final userData = snapshot.data as User;
                                return Container(
                                  padding: const EdgeInsets.all(8),
                                  width: 300,
                                  height: 300,
                                  child: Card(
                                    shadowColor: Colors.grey.shade500,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          tutor.imageData != null
                                              ? Image.memory(
                                                  base64Decode(
                                                      tutor.imageData!),
                                                  width: 255,
                                                  height: 120,
                                                  fit: BoxFit.fill)
                                              : Image.asset(
                                                  'lib/assets/images/profile_placeholder.jpg',
                                                  width: 270,
                                                  height: 120,
                                                  fit: BoxFit.fill,
                                                ),
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TutorDisplayWidget(
                                                text: userData.fullName,
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
                                            text: 'Bio: ${userData.education}',
                                          ),
                                          const Gap(2),
                                          TutorDisplayWidget(
                                            text:
                                                'interested: ${tutor.subjectOfInterest.toString().split('.').last}',
                                          ),
                                          const Gap(2),
                                          TutorDisplayWidget(
                                            text:
                                                'Class: ${tutor.expectedStudent.toString().split('.').last.replaceAll('_', ' ').replaceAll('to', '-')}',
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                MaterialButton(
                                                  onPressed: () async {
                                                    await _pickImage(
                                                      tutors[tutors.length -
                                                          (screenSize.width <
                                                                  800
                                                              ? 2
                                                              : 4) +
                                                          index],
                                                    );
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
                                                    'Pick Image',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
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
