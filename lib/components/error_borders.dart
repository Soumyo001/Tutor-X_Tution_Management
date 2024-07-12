import 'package:flutter/Material.dart';

class ErrorBorders {
  static InputBorder? errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: Colors.redAccent.shade200.withOpacity(0.8),
    ),
  );
  static InputBorder? errorFocusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: Colors.red.shade900,
    ),
  );
  static TextStyle? errorTextStyle = TextStyle(
    color: Colors.red.shade900,
  );
  static TextStyle? errorTextStylePassword = TextStyle(
    color: Colors.red.shade900,
  );
  static InputBorder? errorBorderPassword = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: Colors.redAccent.shade200.withOpacity(0.8),
    ),
  );
  static InputBorder? errorFocusedBorderPassword = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: Colors.red.shade900,
    ),
  );
  static TextStyle? errorTextStylePasswordC = TextStyle(
    color: Colors.red.shade900,
  );
  static InputBorder? errorBorderPasswordC = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: Colors.redAccent.shade200.withOpacity(0.8),
    ),
  );
  static InputBorder? errorFocusedBorderPasswordC = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: Colors.red.shade900,
    ),
  );
  static String errorTextPassword = '';
  static String errorTextPasswordC = '';
  static String errorTextEmail = '';
  static String errorTextPhoneNumber = '';
  static String errorTextFirstName = '';
  static String errorTextLastName = '';
  static String errorTextFullName = '';
}
