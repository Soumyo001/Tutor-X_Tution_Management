import 'package:flutter/material.dart';

class InputBox2 extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final int? maxLength;
  final double? fontSize;
  const InputBox2({
    super.key,
    required this.hintText,
    required this.controller,
    this.maxLength = 200,
    this.fontSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      maxLines: 4,
      style: TextStyle(
        color: Colors.black87,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade600),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
      ),
    );
  }
}
