import 'package:flutter/Material.dart';
import 'package:tutor_x_tution_management/components/input_box2.dart';

class LabeledInputBox extends StatelessWidget {
  final String label;
  final String inputHint;
  final TextEditingController controller;
  final double width;
  const LabeledInputBox(
      {super.key,
      required this.label,
      required this.controller,
      required this.width,
      required this.inputHint});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Text(label),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: width,
          child: InputBox2(
            hintText: inputHint,
            controller: controller,
            maxLength: null,
          ),
        ),
      ],
    );
  }
}
