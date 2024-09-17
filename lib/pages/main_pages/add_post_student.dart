// ignore_for_file: use_build_context_synchronously

import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tutor_x_tution_management/components/icon_button.dart';
import 'package:tutor_x_tution_management/components/labeled_input_box.dart';
import 'package:tutor_x_tution_management/components/tutor_profile_extra_info.dart';
import 'package:tutor_x_tution_management/controllers/enum_controller.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/models/student_post.dart';
import 'package:tutor_x_tution_management/service/api/student_post_api.dart';
import 'package:tutor_x_tution_management/utils/dialogs/error_dialog.dart';
import 'package:tutor_x_tution_management/utils/dialogs/success_dialog.dart';
import 'package:tutor_x_tution_management/utils/generics/add_post_generic_drop_down.dart';

class AddPostByStudent extends StatefulWidget {
  const AddPostByStudent({super.key});

  @override
  State<AddPostByStudent> createState() => _AddPostByStudentState();
}

class _AddPostByStudentState extends State<AddPostByStudent> {
  late final UserStaticsController _userStaticsController;
  late final TextEditingController _desc;
  late final TextEditingController _salary;

  @override
  void initState() {
    super.initState();
    _userStaticsController = Get.find<UserStaticsController>();
    _desc = TextEditingController();
    _salary = TextEditingController();
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TutorProfileExtraInfo(
                    extraInfo: _userStaticsController.userName, label: 'Name'),
                TutorProfileExtraInfo(
                    extraInfo:
                        _userStaticsController.student!.studentSelfDescription,
                    label: 'Self Description'),
                TutorProfileExtraInfo(
                    extraInfo: _userStaticsController.userLocation,
                    label: 'Location'),
                AddPostDropDown<StudentTypes>(
                  text: 'Class: ',
                  values: StudentTypes.values,
                  value: enumController.studentTypes,
                  onChanged: (value) {
                    enumController.studentTypes = value!;
                  },
                ),
                AddPostDropDown<StudentMedium>(
                  text: 'Student Medium : ',
                  values: StudentMedium.values,
                  value: enumController.studentMedium,
                  onChanged: (p0) {
                    enumController.studentMedium = p0!;
                  },
                ),
                AddPostDropDown<SubjectTypes>(
                  text: 'Subject : ',
                  values: SubjectTypes.values,
                  value: enumController.subjectTypes,
                  onChanged: (p0) {
                    enumController.subjectTypes = p0!;
                  },
                ),
                AddPostDropDown<TutionDays>(
                  text: 'Tution Days : ',
                  values: TutionDays.values,
                  value: enumController.tutionDays,
                  onChanged: (p0) {
                    enumController.tutionDays = p0!;
                  },
                ),
                LabeledInputBox(
                  label: 'Salary : ',
                  controller: _salary,
                  width: screenSize.width * 0.4,
                  inputHint: 'Salary of your capabilities...',
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
                            int? salary = int.tryParse(_salary.text);
                            if (salary == null) {
                              await showErrorDialog(
                                  context, 'Invalid Input in Salary tab');
                            } else {
                              final studentPost = StudentPost(
                                studentPostId: 0,
                                studentId:
                                    _userStaticsController.student!.studentId,
                                fullName: _userStaticsController.userName,
                                days: enumController.tutionDays,
                                location: _userStaticsController.userLocation,
                                studentDes: _desc.text,
                                education: _userStaticsController.userEducation,
                                studentMedium: enumController.studentMedium,
                                studentTypes: enumController.studentTypes,
                                subjectTypes: enumController.subjectTypes,
                                salary: salary,
                              );
                              final response = await StudentPostApi()
                                  .postStudentPost(
                                      requestBody: studentPost.toJson());
                              if (response.statusCode >= 200 &&
                                  response.statusCode <= 299) {
                                await showSuccessDialog(context,
                                    'Your post was successfully submitted.');
                                Get.back();
                              } else {
                                await showErrorDialog(context,
                                    'There was a problem posting your post');
                              }
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
      ),
    );
  }
}
