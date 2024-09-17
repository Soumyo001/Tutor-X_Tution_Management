import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_x_tution_management/utils/color_pallete.dart';
import 'package:tutor_x_tution_management/controllers/enum_controller.dart';
import 'package:tutor_x_tution_management/data/enums.dart';

class RegistrationStudentMedium extends StatefulWidget {
  const RegistrationStudentMedium({super.key});

  @override
  State<RegistrationStudentMedium> createState() =>
      _RegistrationStudentMediumState();
}

class _RegistrationStudentMediumState extends State<RegistrationStudentMedium> {
  @override
  Widget build(BuildContext context) {
    final EnumController enumController = Provider.of<EnumController>(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Pallete.gradiant2,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Student Medium: ',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        DropdownButton<StudentMedium>(
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
          value: enumController.studentMedium,
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
              enumController.studentMedium = value!;
            });
          },
        ),
      ],
    );
  }
}
