import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tutor_x_tution_management/components/input_box.dart';
import 'package:tutor_x_tution_management/components/registration_student_medium.dart';
import 'package:tutor_x_tution_management/components/registration_student_types.dart';
import 'package:tutor_x_tution_management/components/registration_tutor_subject_of_interest.dart';

class TutorInfo extends StatefulWidget {
  final void Function(int) change;
  final TextEditingController educationController;
  final TextEditingController locationController;
  final TextEditingController salaryController;
  const TutorInfo({
    super.key,
    required this.change,
    required this.educationController,
    required this.locationController,
    required this.salaryController,
  });

  @override
  State<TutorInfo> createState() => _TutorInfoState();
}

class _TutorInfoState extends State<TutorInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            right: 20.0,
            left: 27.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RegistrationStudentMedium(),
              RegistrationSubjectOfInterest(),
              RegistrationStudentTypes(),
            ],
          ),
        ),
        const Gap(25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InputBox(
              textEditingController: widget.educationController,
              hintText: 'College/University Name',
              autoCorrect: false,
              enableSuggestions: false,
              obscureText: false,
              maxWidth: 400,
            ),
            const Gap(10),
            InputBox(
              textEditingController: widget.locationController,
              hintText: 'Place you live in',
              autoCorrect: false,
              enableSuggestions: false,
              obscureText: false,
              maxWidth: 400,
            ),
          ],
        ),
        const Gap(25),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: InputBox(
            textEditingController: widget.salaryController,
            hintText: 'Expected Salary',
            autoCorrect: false,
            enableSuggestions: false,
            obscureText: false,
          ),
        ),
        const Gap(25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
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
                onPressed: () {
                  widget.change(1);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(24),
                  backgroundColor: Colors.amber.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  foregroundColor: Colors.amberAccent.shade100,
                ),
                icon: const SizedBox.shrink(),
                label: const Row(
                  children: [
                    Text(
                      'Go next',
                      style: TextStyle(color: Colors.black),
                    ),
                    Gap(8),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
