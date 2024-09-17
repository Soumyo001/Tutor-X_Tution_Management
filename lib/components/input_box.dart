import 'package:flutter/material.dart';
import 'package:tutor_x_tution_management/utils/color_pallete.dart';

class InputBox extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool autoCorrect, enableSuggestions, obscureText;
  final Widget? suffixIcon;
  final double? fontSize;
  final double? maxWidth;
  final int? maxLines, maxLength;
  final void Function(String)? onChanged;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final TextStyle? errorStyle;
  final TextInputType? keyboardType;
  final String? errorText;

  const InputBox({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.autoCorrect,
    required this.enableSuggestions,
    required this.obscureText,
    this.suffixIcon,
    this.fontSize,
    this.maxWidth = 400,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.errorBorder,
    this.focusedErrorBorder,
    this.errorStyle,
    this.keyboardType,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth!),
      child: TextField(
        controller: textEditingController,
        obscureText: obscureText,
        enableSuggestions: enableSuggestions,
        onChanged: onChanged,
        autocorrect: autoCorrect,
        cursorColor: Pallete.gradiant2,
        cursorWidth: 1.0,
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: fontSize,
        ),
        maxLength: maxLength,
        maxLines: maxLines,
        decoration: InputDecoration(
          errorText: errorText,
          errorStyle: errorStyle,
          errorBorder: errorBorder,
          focusedErrorBorder: focusedErrorBorder,
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Pallete.gradiant2,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
