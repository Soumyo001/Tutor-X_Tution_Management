import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tutor_x_tution_management/components/icon_button.dart';
import 'package:tutor_x_tution_management/components/input_box2.dart';
import 'package:tutor_x_tution_management/components/tutor_selection_edit.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'package:tutor_x_tution_management/service/api/tutor_api.dart';
import 'dart:developer' as dev;

import 'package:tutor_x_tution_management/utils/dialogs/error_dialog.dart';

class TutorProfileViewEdit extends StatefulWidget {
  const TutorProfileViewEdit({super.key});

  @override
  State<TutorProfileViewEdit> createState() => _TutorProfileViewEditState();
}

class _TutorProfileViewEditState extends State<TutorProfileViewEdit> {
  Uint8List? _imageData;
  late final UserStaticsController _userStaticsController;
  late final TextEditingController _desc;
  late final TextEditingController _salary;
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
            _userStaticsController.tutor!.imageData = base64Encode(_imageData!);
            _userStaticsController.imageData = _imageData;
          });
          await TutorApi().updateTutor(
            tutorId: _userStaticsController.tutor!.tutorId,
            body: _userStaticsController.tutor!.toJson(),
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
    _salary = TextEditingController();
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
                          _userStaticsController.tutor!.imageData != null
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
                              _userStaticsController.tutorSelfDesc = _desc.text;
                              _userStaticsController
                                  .tutor!.tutorSelfDescription = _desc.text;
                              await TutorApi().updateTutor(
                                tutorId: _userStaticsController.tutor!.tutorId,
                                body: _userStaticsController.tutor!.toJson(),
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
                    'Expected Salary : ',
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
                        hintText: 'Salary that meets your expectations...',
                        controller: _salary,
                      ),
                      const Gap(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ButtonIcon(
                            label: 'Save',
                            icon: Icons.save,
                            onPressed: () async {
                              int? sa = int.tryParse(_salary.text);
                              if (sa == null) {
                                await showErrorDialog(context, 'Invalid Input');
                              } else {
                                _userStaticsController.tutorSalary = sa;
                                _userStaticsController.tutor!.expectedSalary =
                                    sa;
                                await TutorApi().updateTutor(
                                  tutorId:
                                      _userStaticsController.tutor!.tutorId,
                                  body: _userStaticsController.tutor!.toJson(),
                                );
                              }
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
                    child: TutorSelectionEdit(
                      onSelectionDone: () async {
                        await TutorApi().updateTutor(
                          tutorId: _userStaticsController.tutor!.tutorId,
                          body: _userStaticsController.tutor!.toJson(),
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
