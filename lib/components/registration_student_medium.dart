import 'package:flutter/material.dart';
import 'package:tutor_x_tution_management/color_pallete.dart';
import 'package:tutor_x_tution_management/data/enums.dart';

class RegistrationStudentMedium extends StatefulWidget {
  const RegistrationStudentMedium({super.key});

  @override
  State<RegistrationStudentMedium> createState() =>
      _RegistrationStudentMediumState();
}

class _RegistrationStudentMediumState extends State<RegistrationStudentMedium> {
  StudentMedium studentMedium = StudentMedium.bangla;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<StudentMedium>(
      borderRadius: BorderRadius.circular(10),
      style: const TextStyle(fontSize: 12),
      icon: const Icon(
        Icons.arrow_drop_down_rounded,
        color: Pallete.gradiant2,
      ),
      underline: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
          ),
        ),
      ),
      padding: const EdgeInsets.all(12),
      value: studentMedium,
      items: const [
        DropdownMenuItem(
          value: StudentMedium.bangla,
          child: Text(
            'Bangla',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 17,
            ),
          ),
        ),
        DropdownMenuItem(
          value: StudentMedium.english,
          child: Text(
            'English',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 17,
            ),
          ),
        ),
      ],
      onChanged: (value) {
        setState(() {
          studentMedium = value!;
        });
      },
    );
  }
}
