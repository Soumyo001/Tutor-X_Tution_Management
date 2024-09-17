import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_x_tution_management/utils/color_pallete.dart';
import 'package:tutor_x_tution_management/controllers/enum_controller.dart';
import 'package:tutor_x_tution_management/data/enums.dart';

class RegistrationUserCategory extends StatefulWidget {
  const RegistrationUserCategory({super.key});

  @override
  State<RegistrationUserCategory> createState() =>
      _RegistrationUserCategoryState();
}

class _RegistrationUserCategoryState extends State<RegistrationUserCategory> {
  @override
  Widget build(BuildContext context) {
    final EnumController enumController = Provider.of<EnumController>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'I am a :',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
        ),
        DropdownButton<UserCategory>(
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
          value: enumController.userCategory,
          items: const [
            DropdownMenuItem(
              value: UserCategory.teacher,
              child: Text(
                'Teacher',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
            ),
            DropdownMenuItem(
              value: UserCategory.student,
              child: Text(
                'Student',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
            ),
          ],
          onChanged: (value) {
            enumController.userCategory = value!;
          },
        ),
      ],
    );
  }
}
