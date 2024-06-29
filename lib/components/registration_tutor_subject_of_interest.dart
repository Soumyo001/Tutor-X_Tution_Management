import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:tutor_x_tution_management/color_pallete.dart';
import 'package:tutor_x_tution_management/controllers/enum_controller.dart';
import 'package:tutor_x_tution_management/data/enums.dart';

class RegistrationSubjectOfInterest extends StatefulWidget {
  const RegistrationSubjectOfInterest({super.key});

  @override
  State<RegistrationSubjectOfInterest> createState() =>
      _RegistrationSubjectOfInterestState();
}

class _RegistrationSubjectOfInterestState
    extends State<RegistrationSubjectOfInterest> {
  @override
  Widget build(BuildContext context) {
    final EnumController enumController = Provider.of<EnumController>(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 21, 9, 183),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Subject Type: ',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const Gap(10),
        DropdownButton<SubjectTypes>(
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
          value: enumController.subjectTypes,
          items: const [
            DropdownMenuItem(
              value: SubjectTypes.bangla,
              child: Text('Bangla'),
            ),
            DropdownMenuItem(
              value: SubjectTypes.english,
              child: Text('English'),
            ),
            DropdownMenuItem(
              value: SubjectTypes.biology,
              child: Text('Biology'),
            ),
            DropdownMenuItem(
              value: SubjectTypes.physics,
              child: Text('Physics'),
            ),
            DropdownMenuItem(
              value: SubjectTypes.mathematics,
              child: Text('Mathematics'),
            ),
            DropdownMenuItem(
              value: SubjectTypes.chemistry,
              child: Text('Chemistry'),
            ),
            DropdownMenuItem(
              value: SubjectTypes.higher_mathematics,
              child: Text('Higher Mathematics'),
            ),
            DropdownMenuItem(
              value: SubjectTypes.science,
              child: Text('Science'),
            ),
          ],
          onChanged: (value) {
            enumController.subjectTypes = value!;
          },
        ),
      ],
    );
  }
}
