import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:tutor_x_tution_management/components/input_box.dart';

class StudentInfo2 extends StatefulWidget {
  final void Function(int) change;
  final TextEditingController educationController, locationController;
  final String firstName, lastName, email, password, phoneNumber;
  const StudentInfo2({
    super.key,
    required this.change,
    required this.educationController,
    required this.locationController,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  @override
  State<StudentInfo2> createState() => _StudentInfo2State();
}

class _StudentInfo2State extends State<StudentInfo2> {
  late final TextEditingController _desc;

  @override
  void initState() {
    super.initState();
    _desc = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          InputBox(
            textEditingController: _desc,
            hintText: 'Bio',
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
                    widget.change(0);
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
      ),
    );
  }
}
