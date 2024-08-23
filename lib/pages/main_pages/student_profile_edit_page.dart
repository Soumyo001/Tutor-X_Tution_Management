import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tutor_x_tution_management/components/icon_button.dart';
import 'package:tutor_x_tution_management/components/input_box2.dart';
import 'package:tutor_x_tution_management/components/student_selection_edit.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'package:tutor_x_tution_management/service/api/student_api.dart';
import 'dart:developer' as dev;

class StudentProfileEditPage extends StatefulWidget {
  const StudentProfileEditPage({super.key});

  @override
  State<StudentProfileEditPage> createState() => _StudentProfileEditPageState();
}

class _StudentProfileEditPageState extends State<StudentProfileEditPage> {
  Uint8List? _imageData;
  late final UserStaticsController _userStaticsController;
  late final TextEditingController _desc;
  late final TextEditingController _studentEd;
  final RxBool loading = false.obs;

  Future<void> _pickImage() async {
    if (kIsWeb) {
      try {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          final f = await image.readAsBytes();
          setState(() {
            _imageData = f;
            _userStaticsController.student!.imageData =
                base64Encode(_imageData!);
            _userStaticsController.imageData = _imageData;
          });
          await StudentApi().updateStudent(
            studentId: _userStaticsController.student!.studentId,
            body: _userStaticsController.student!.toJson(),
          );
          dev.log(base64Encode(_imageData!));
        }
      } catch (e) {
        dev.log(
            'while picking image in tutor profile edit page: ${e.toString()}');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _userStaticsController = Get.find<UserStaticsController>();
    _desc = TextEditingController();
    _studentEd = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Edit your Profile',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(
                color: Colors.grey.shade500.withAlpha(150),
                thickness: 0.5,
                height: 0.5,
              ),
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Profile Picture',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ButtonIcon(
                    label: 'Edit',
                    icon: Icons.edit,
                    onPressed: () async {
                      await _pickImage();
                    },
                    enableIcon: true,
                    loading: false,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => CircleAvatar(
                      radius: 180,
                      backgroundImage:
                          _userStaticsController.student!.imageData != null
                              ? MemoryImage(_userStaticsController.imageData!)
                              : null,
                      child: _userStaticsController.imageData == null
                          ? Image.asset(
                              'lib/assets/images/profile_placeholder.jpg',
                              fit: BoxFit.fill,
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    'Education : ',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenSize.width / 3,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      InputBox2(
                        hintText: 'School/College/Degree(University)',
                        controller: _studentEd,
                      ),
                      const Gap(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ButtonIcon(
                            label: 'Save',
                            icon: Icons.save,
                            onPressed: () async {
                              _userStaticsController.userEducation =
                                  _studentEd.text;
                              await StudentApi().updateStudent(
                                studentId:
                                    _userStaticsController.student!.studentId,
                                body: _userStaticsController.student!.toJson(),
                              );
                            },
                            enableIcon: true,
                            loading: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    'Bio : ',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenSize.width / 3,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      InputBox2(
                          hintText: 'Write something about yourself...',
                          controller: _desc),
                      const Gap(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ButtonIcon(
                            label: 'Save',
                            icon: Icons.save,
                            onPressed: () async {
                              _userStaticsController.studentSelfDesc =
                                  _desc.text;
                              _userStaticsController
                                  .student!.studentSelfDescription = _desc.text;
                              await StudentApi().updateStudent(
                                studentId:
                                    _userStaticsController.student!.studentId,
                                body: _userStaticsController.student!.toJson(),
                              );
                            },
                            enableIcon: true,
                            loading: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenSize.width / 3,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                    ),
                    child: StudentSelectionEdit(
                      onSelectionDone: () async {
                        await StudentApi().updateStudent(
                          studentId: _userStaticsController.student!.studentId,
                          body: _userStaticsController.student!.toJson(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
