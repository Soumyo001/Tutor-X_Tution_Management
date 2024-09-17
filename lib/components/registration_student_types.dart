import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_x_tution_management/utils/color_pallete.dart';
import 'package:tutor_x_tution_management/controllers/enum_controller.dart';
import 'package:tutor_x_tution_management/data/enums.dart';

class RegistrationStudentTypes extends StatelessWidget {
  const RegistrationStudentTypes({super.key});

  @override
  Widget build(BuildContext context) {
    final EnumController enumController = Provider.of<EnumController>(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Pallete.gradiant3,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Student Type: ',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        DropdownButton<StudentTypes>(
          borderRadius: BorderRadius.circular(10),
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
          value: enumController.studentTypes,
          items: const [
            DropdownMenuItem(
              value: StudentTypes.kinder_garden,
              child: Text('Kinder Garden'),
            ),
            DropdownMenuItem(
              value: StudentTypes.class_1_to_class_5,
              child: Text('Class 1 - Class 5'),
            ),
            DropdownMenuItem(
              value: StudentTypes.class_5_to_class_10,
              child: Text('Class 5 - Class 10'),
            ),
            DropdownMenuItem(
              value: StudentTypes.college_level,
              child: Text('College'),
            ),
          ],
          onChanged: (value) {
            enumController.studentTypes = value!;
          },
        ),
      ],
    );
  }
}
