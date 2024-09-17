import 'package:flutter/material.dart';

class InputBox2 extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final int? maxLength;
  final double? fontSize;
  final int? maxLines;
  final bool alternativeColor;
  final Color? customColor;
  final Color? customFocusColor;
  final bool disableMaxLengthAndLines;
  const InputBox2({
    super.key,
    required this.hintText,
    required this.controller,
    this.maxLength = 200,
    this.fontSize = 16.0,
    this.alternativeColor = false,
    this.disableMaxLengthAndLines = false,
    this.maxLines = 4,
    this.customColor,
    this.customFocusColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: disableMaxLengthAndLines ? null : maxLength,
      maxLines: disableMaxLengthAndLines ? null : maxLines,
      style: TextStyle(
        color: Colors.black87,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: alternativeColor
                ? Colors.lightBlue
                : (customColor != null ? customColor! : Colors.grey.shade600),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: alternativeColor
                ? Colors.lightBlue
                : (customFocusColor != null
                    ? customFocusColor!
                    : Colors.grey.shade200),
          ),
        ),
      ),
    );
  }
}
