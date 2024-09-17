import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_x_tution_management/utils/color_pallete.dart';
import 'package:tutor_x_tution_management/controllers/enum_controller.dart';
import 'package:tutor_x_tution_management/data/enums.dart';

class TutorProfessionType extends StatefulWidget {
  const TutorProfessionType({super.key});

  @override
  State<TutorProfessionType> createState() => _TutorProfessionTypeState();
}

class _TutorProfessionTypeState extends State<TutorProfessionType> {
  @override
  Widget build(BuildContext context) {
    final EnumController enumController = Provider.of<EnumController>(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Profession: '),
        DropdownButton<ProfessionType>(
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
          value: enumController.professionType,
          items: const [
            DropdownMenuItem(
              value: ProfessionType.student,
              child: Text('Student'),
            ),
            DropdownMenuItem(
              value: ProfessionType.doctor,
              child: Text('Doctor'),
            ),
            DropdownMenuItem(
              value: ProfessionType.engineer,
              child: Text('Engineer'),
            ),
            DropdownMenuItem(
              value: ProfessionType.businessman,
              child: Text('Businessman'),
            ),
            DropdownMenuItem(
              value: ProfessionType.scientist,
              child: Text('Scientist'),
            ),
            DropdownMenuItem(
              value: ProfessionType.unemployed,
              child: Text('Unemployed'),
            ),
          ],
          onChanged: (value) {
            enumController.professionType = value!;
          },
        ),
      ],
    );
  }
}
