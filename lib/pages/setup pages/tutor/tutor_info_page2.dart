// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:tutor_x_tution_management/components/input_box.dart';
import 'package:tutor_x_tution_management/controllers/enum_controller.dart';
import 'package:tutor_x_tution_management/models/tutor.dart';
import 'package:tutor_x_tution_management/models/user.dart';
import 'package:tutor_x_tution_management/service/api/tutor_api.dart';
import 'package:tutor_x_tution_management/service/api/user_api.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

class TutorInfo2 extends StatefulWidget {
  final void Function(int) change;
  final String fullName, phoneNumber, email, password;
  final TextEditingController educationController;
  final TextEditingController locationController;
  final TextEditingController salaryController;
  const TutorInfo2({
    super.key,
    required this.change,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.educationController,
    required this.locationController,
    required this.salaryController,
  });

  @override
  State<TutorInfo2> createState() => _TutorInfo2State();
}

class _TutorInfo2State extends State<TutorInfo2> {
  late final TextEditingController _desc;

  @override
  void initState() {
    super.initState();
    _desc = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final e = Provider.of<EnumController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InputBox(
          textEditingController: _desc,
          hintText: 'Tell us about yourself',
          autoCorrect: false,
          enableSuggestions: false,
          obscureText: false,
          maxLength: 200,
          maxLines: 5,
        ),
        const Gap(30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {
                  widget.change(1);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(24),
                  backgroundColor: const Color.fromARGB(255, 17, 73, 230),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  foregroundColor: Colors.amberAccent.shade100,
                ),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                label: const Text(
                  'Go Back',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton.icon(
                onPressed: () async {
                  final user = User(
                    userId: 0,
                    fullName: widget.fullName,
                    phoneNumber: widget.phoneNumber,
                    email: widget.email,
                    password: widget.password,
                    education: widget.educationController.text,
                    location: widget.locationController.text,
                    userReports: 0,
                    userType: e.userCategory,
                  );
                  final responseUser =
                      await UserApi().postUser(requestBody: user.toJson());
                  if (responseUser.statusCode >= 200 &&
                      responseUser.statusCode <= 299) {
                    final body = jsonDecode(responseUser.body);
                    final userId = body[userIdColumn];
                    final tutor = Tutor(
                      tutorId: 0,
                      userId: userId,
                      status: e.availabilityStatus,
                      mediumOfInterest: e.studentMedium,
                      expectedStudent: e.studentTypes,
                      subjectOfInterest: e.subjectTypes,
                      expectedSalary: int.parse(widget.salaryController.text),
                      profession: e.professionType,
                      verificationStatus: e.verificationStatus,
                      tutorSelfDescription: _desc.text,
                      imageData: null,
                    );

                    await TutorApi().postTutor(requestBody: tutor.toJson());
                  }

                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(24),
                  backgroundColor: Colors.amber.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  foregroundColor: Colors.amberAccent.shade100,
                ),
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
                label: const Text(
                  'I\'m Ready !',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
