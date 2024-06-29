import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tutor_x_tution_management/components/input_box.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/components/registration_tutor_profession_type.dart';

class TutorRegistrationForm extends StatefulWidget {
  const TutorRegistrationForm({super.key});

  @override
  State<TutorRegistrationForm> createState() => _TutorRegistrationFormState();
}

class _TutorRegistrationFormState extends State<TutorRegistrationForm> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailEditingController;
  late final TextEditingController _passwordEditingController;
  late final TextEditingController _phoneController;
  RxBool isPasswrodVisible = false.obs;
  TextStyle? errorTextStyle = const TextStyle();
  TextStyle? errorTextStyleC = const TextStyle();
  TextStyle? errorTextStyleEmail = const TextStyle();
  InputBorder? errorBorder = const OutlineInputBorder();
  InputBorder? errorBorderC = const OutlineInputBorder();
  InputBorder? errorBorderEmail = const OutlineInputBorder();
  InputBorder? errorFocusedBorder = const OutlineInputBorder();
  InputBorder? errorFocusedBorderC = const OutlineInputBorder();
  InputBorder? errorFocusedBorderEmail = const OutlineInputBorder();
  String errorText = '';
  String errorTextC = '';
  String errorTextEmail = '';
  final RegExp passPattern = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,}$',
    caseSensitive: false,
    multiLine: false,
  );
  final RegExp emailPattern = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  void onEmailChange(String value) {
    if (!emailPattern.hasMatch(value) && value.isNotEmpty) {
      setState(() {
        errorTextEmail = 'Invalid Email';
        errorBorderEmail = OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.redAccent.shade200.withOpacity(0.8),
          ),
        );
        errorFocusedBorderEmail = OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red.shade900,
          ),
        );
        errorTextStyleEmail = TextStyle(
          color: Colors.red.shade900,
        );
      });
    } else {
      setState(() {
        errorTextEmail = '';
      });
    }
  }

  void onPasswordChange(String value) {
    if (value.isEmpty) {
      setState(() {
        errorText = '';
      });
    } else if (!passPattern.hasMatch(value)) {
      setState(() {
        errorText = 'Weak Password';
        errorBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.redAccent.shade200.withOpacity(0.8),
          ),
        );
        errorFocusedBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red.shade900,
          ),
        );
        errorTextStyle = TextStyle(
          color: Colors.red.shade900,
        );
      });
    } else {
      setState(() {
        errorText = 'Strong Password';
        errorBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.green.shade500,
          ),
        );
        errorFocusedBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.green.shade900,
          ),
        );
        errorTextStyle = TextStyle(
          color: Colors.green.shade900,
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: InputBox(
            textEditingController: _fullNameController,
            hintText: 'Full Name',
            autoCorrect: false,
            enableSuggestions: false,
            obscureText: false,
            fontSize: 14,
            maxWidth: 600,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TutorProfessionType(),
            const Gap(10),
            InputBox(
              textEditingController: _phoneController,
              hintText: 'Phone Number',
              autoCorrect: false,
              enableSuggestions: false,
              obscureText: false,
              maxWidth: 210,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        InputBox(
          textEditingController: _emailEditingController,
          hintText: 'E-mail',
          autoCorrect: false,
          enableSuggestions: false,
          obscureText: false,
          maxWidth: 440,
          keyboardType: TextInputType.emailAddress,
          onChanged: onEmailChange,
          errorText: (errorTextEmail.isEmpty ? null : errorTextEmail),
          errorStyle: errorTextStyleEmail,
          errorBorder: errorBorderEmail,
          focusedErrorBorder: errorFocusedBorderEmail,
        ),
        const Gap(10),
        Obx(
          () => InputBox(
            textEditingController: _passwordEditingController,
            hintText: 'Password',
            autoCorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.visiblePassword,
            obscureText: isPasswrodVisible.value,
            fontSize: 14,
            maxWidth: 440,
            suffixIcon: InkWell(
              onTap: () {
                isPasswrodVisible.value = !isPasswrodVisible.value;
              },
              child: Icon(
                isPasswrodVisible.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.black,
              ),
            ),
            onChanged: onPasswordChange,
            errorText: (errorText.isEmpty ? null : errorText),
            errorStyle: errorTextStyle,
            errorBorder: errorBorder,
            focusedErrorBorder: errorFocusedBorder,
          ),
        ),
      ],
    );
  }
}
