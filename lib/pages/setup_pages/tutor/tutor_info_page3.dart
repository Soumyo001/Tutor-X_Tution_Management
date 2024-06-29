import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:tutor_x_tution_management/components/input_box.dart';
import 'package:tutor_x_tution_management/controllers/enum_controller.dart';
import 'package:tutor_x_tution_management/data/enums.dart';
import 'dart:developer' as dev;

class TutorInfo2 extends StatefulWidget {
  final void Function(int) change;
  final String fullName, phoneNumber, email, password;
  final ProfessionType professionType;
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
    required this.professionType,
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
    EnumController e = Provider.of<EnumController>(context);
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
                onPressed: () {
                  dev.log(widget.email);
                  dev.log(widget.fullName);
                  dev.log(widget.password);
                  dev.log(widget.phoneNumber);
                  dev.log(widget.email);
                  dev.log(e.availabilityStatus.toString());
                  dev.log(e.professionType.toString());
                  dev.log(e.studentMedium.toString());
                  dev.log(e.subjectTypes.toString());
                  dev.log(e.studentTypes.toString());
                  dev.log(e.userCategory.toString());
                  dev.log(widget.educationController.text);
                  dev.log(widget.locationController.text);
                  dev.log(widget.salaryController.text);
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
