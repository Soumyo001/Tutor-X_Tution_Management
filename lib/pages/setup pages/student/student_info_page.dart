import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:tutor_x_tution_management/components/input_box.dart';
import 'package:tutor_x_tution_management/components/registration_student_medium.dart';

class StudentInfo extends StatefulWidget {
  final void Function(int) change;
  final TextEditingController educationController, locationController;
  const StudentInfo({
    super.key,
    required this.change,
    required this.educationController,
    required this.locationController,
  });

  @override
  State<StudentInfo> createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RegistrationStudentMedium(),
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
      ),
    );
  }
}
