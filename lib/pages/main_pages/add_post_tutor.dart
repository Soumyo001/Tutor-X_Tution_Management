// ignore_for_file: use_build_context_synchronously

import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tutor_x_tution_management/components/icon_button.dart';
import 'package:tutor_x_tution_management/components/labeled_input_box.dart';
import 'package:tutor_x_tution_management/models/tutor_post.dart';
import 'package:tutor_x_tution_management/service/api/tutor_post_api.dart';
import 'package:tutor_x_tution_management/utils/dialogs/error_dialog.dart';
import 'package:tutor_x_tution_management/utils/dialogs/success_dialog.dart';
import 'package:tutor_x_tution_management/utils/generics/add_post_generic_drop_down.dart';
import 'package:tutor_x_tution_management/components/tutor_profile_extra_info.dart';
import 'package:tutor_x_tution_management/controllers/enum_controller.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'package:tutor_x_tution_management/data/enums.dart';

class AddPostByTutor extends StatefulWidget {
  const AddPostByTutor({super.key});

  @override
  State<AddPostByTutor> createState() => _AddPostByTutorState();
}

class _AddPostByTutorState extends State<AddPostByTutor> {
  late final UserStaticsController _userStaticsController;
  late final TextEditingController _desc;

  @override
  void initState() {
    super.initState();
    _userStaticsController = Get.find<UserStaticsController>();
    _desc = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final EnumController enumController = Provider.of<EnumController>(context);
    return Scaffold(
      body: Center(
        child: Container(
          width: screenSize.width * 0.5,
          height: screenSize.height * 0.63,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TutorProfileExtraInfo(
                  extraInfo: _userStaticsController.userName, label: 'Name'),
              TutorProfileExtraInfo(
                  extraInfo: _userStaticsController.tutor!.tutorSelfDescription,
                  label: 'Self Description'),
              TutorProfileExtraInfo(
                  extraInfo: _userStaticsController.userLocation,
                  label: 'Location'),
              AddPostDropDown<StudentTypes>(
                text: 'Student Type : ',
                values: StudentTypes.values,
                value: enumController.studentTypes,
                onChanged: (value) {
                  enumController.studentTypes = value!;
                },
              ),
              AddPostDropDown<StudentMedium>(
                text: 'Medium of Interest : ',
                values: StudentMedium.values,
                value: enumController.studentMedium,
                onChanged: (p0) {
                  enumController.studentMedium = p0!;
                },
              ),
              AddPostDropDown<SubjectTypes>(
                text: 'Subject of Interest : ',
                values: SubjectTypes.values,
                value: enumController.subjectTypes,
                onChanged: (p0) {
                  enumController.subjectTypes = p0!;
                },
              ),
              LabeledInputBox(
                label: 'Description : ',
                controller: _desc,
                width: screenSize.width * 0.4,
                inputHint: 'what\'s in your mind ?',
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonIcon(
                        icon: Icons.save,
                        label: 'Post',
                        onPressed: () async {
                          final tutorPost = TutorPost(
                            tutorPostId: 0,
                            tutorId: _userStaticsController.tutor!.tutorId,
                            fullName: _userStaticsController.userName,
                            bio: _userStaticsController
                                .tutor!.tutorSelfDescription,
                            location: _userStaticsController.userLocation,
                            tutorDes: _desc.text,
                            subjectOfInterest: enumController.subjectTypes,
                            studentMedium: enumController.studentMedium,
                            expectedStudent: enumController.studentTypes,
                          );
                          final response = await TutorPostApi()
                              .postTutorPost(requestBody: tutorPost.toJson());
                          if (response.statusCode >= 200 &&
                              response.statusCode <= 299) {
                            await showSuccessDialog(context,
                                'Your post was successfully submitted.');
                            Get.back();
                          } else {
                            await showErrorDialog(context,
                                'There was a problem posting your post');
                          }
                        },
                        enableIcon: true,
                        loading: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
