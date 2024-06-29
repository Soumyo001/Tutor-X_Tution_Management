import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/components/error_borders.dart';
import 'package:tutor_x_tution_management/components/input_box.dart';
import 'package:tutor_x_tution_management/components/login_signup_button.dart';
import 'package:tutor_x_tution_management/helpers/validator/email_validator.dart';
import 'package:tutor_x_tution_management/helpers/validator/generic_validator.dart';
import 'package:tutor_x_tution_management/helpers/validator/pass_validator.dart';
import 'package:tutor_x_tution_management/helpers/validator/phone_number_validator.dart';

class StudentRegistrationForm extends StatefulWidget {
  const StudentRegistrationForm({super.key});

  @override
  State<StudentRegistrationForm> createState() =>
      _StudentRegistrationFormState();
}

class _StudentRegistrationFormState extends State<StudentRegistrationForm> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailEditingController;
  late final TextEditingController _passwordEditingController;
  late final TextEditingController _phoneController;
  RxBool isPasswrodVisible = false.obs;

  void onEmailChange(String value) {
    if (!EmailValidator().validateEmail(value) && value.isNotEmpty) {
      setState(() {
        ErrorBorders.errorTextEmail = 'Invalid Email';
      });
    } else {
      setState(() {
        ErrorBorders.errorTextEmail = '';
      });
    }
  }

  void onPasswordChange(String value) {
    if (value.isEmpty) {
      setState(() {
        ErrorBorders.errorTextPassword = '';
      });
    } else if (!PasswordValidator().validatePassword(value)) {
      setState(() {
        ErrorBorders.errorTextPassword = 'Weak Password';
        ErrorBorders.errorTextStylePassword = TextStyle(
          color: Colors.red.shade900,
        );
        ErrorBorders.errorBorderPassword = OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.redAccent.shade200.withOpacity(0.8),
          ),
        );
        ErrorBorders.errorFocusedBorderPassword = OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red.shade900,
          ),
        );
      });
    } else {
      setState(() {
        ErrorBorders.errorTextPassword = 'Strong Password';
        ErrorBorders.errorBorderPassword = OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.green.shade500,
          ),
        );
        ErrorBorders.errorFocusedBorderPassword = OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.green.shade900,
          ),
        );
        ErrorBorders.errorTextStylePassword = TextStyle(
          color: Colors.green.shade900,
        );
      });
    }
  }

  void onPhoneNumberChange(String value) {
    if (!PhoneValidator().validate(value) && value.isNotEmpty) {
      setState(() {
        ErrorBorders.errorTextPhoneNumber = 'Invalid Number';
      });
    } else {
      setState(() {
        ErrorBorders.errorTextPhoneNumber = '';
      });
    }
  }

  bool finalValidation() {
    int flag1 = 0, flag2 = 0, flag3 = 0, flag4 = 0;
    setState(() {
      if (!GenericValidator().validate(_firstNameController.text)) {
        ErrorBorders.errorTextFirstName = 'This Field is Required';
        flag1 = 1;
      } else if (!GenericValidator().validate(_lastNameController.text)) {
        ErrorBorders.errorTextLastName = 'This Field is Required';
        flag1 = 1;
      } else {
        ErrorBorders.errorTextFirstName = '';
        ErrorBorders.errorTextLastName = '';
        flag1 = 0;
      }
      if (_phoneController.text.isEmpty) {
        ErrorBorders.errorTextPhoneNumber = 'This Field is Required';
        flag2 = 1;
      } else {
        ErrorBorders.errorTextPhoneNumber = '';
        flag2 = 0;
      }
      if (_emailEditingController.text.isEmpty) {
        ErrorBorders.errorTextEmail = 'This Field is Required';
        flag3 = 1;
      } else {
        ErrorBorders.errorTextEmail = '';
        flag3 = 0;
      }
      if (_passwordEditingController.text.isEmpty) {
        ErrorBorders.errorTextPassword = 'This Field is Required';
        flag4 = 1;
      } else {
        ErrorBorders.errorTextPassword = '';
        flag4 = 0;
      }
    });
    if (flag1 == 1 || flag2 == 1 || flag3 == 1 || flag4 == 1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputBox(
                textEditingController: _firstNameController,
                hintText: 'First Name',
                autoCorrect: false,
                enableSuggestions: false,
                obscureText: false,
                fontSize: 14,
                maxWidth: 180,
                errorText: (ErrorBorders.errorTextFirstName.isEmpty
                    ? null
                    : ErrorBorders.errorTextFirstName),
                errorStyle: ErrorBorders.errorTextStyle,
                errorBorder: ErrorBorders.errorBorder,
                focusedErrorBorder: ErrorBorders.errorFocusedBorder,
              ),
              const Spacer(),
              InputBox(
                textEditingController: _lastNameController,
                hintText: 'Last Name',
                autoCorrect: false,
                enableSuggestions: false,
                obscureText: false,
                fontSize: 14,
                maxWidth: 180,
                errorText: (ErrorBorders.errorTextLastName.isEmpty
                    ? null
                    : ErrorBorders.errorTextLastName),
                errorStyle: ErrorBorders.errorTextStyle,
                errorBorder: ErrorBorders.errorBorder,
                focusedErrorBorder: ErrorBorders.errorFocusedBorder,
              ),
            ],
          ),
        ),
        const Gap(10),
        InputBox(
          textEditingController: _emailEditingController,
          hintText: 'E-mail',
          autoCorrect: false,
          enableSuggestions: false,
          obscureText: false,
          keyboardType: TextInputType.emailAddress,
          onChanged: onEmailChange,
          errorText: (ErrorBorders.errorTextEmail.isEmpty
              ? null
              : ErrorBorders.errorTextEmail),
          errorStyle: ErrorBorders.errorTextStyle,
          errorBorder: ErrorBorders.errorBorder,
          focusedErrorBorder: ErrorBorders.errorFocusedBorder,
        ),
        const Gap(10),
        InputBox(
          textEditingController: _phoneController,
          hintText: 'Phone Number',
          autoCorrect: false,
          onChanged: onPhoneNumberChange,
          enableSuggestions: false,
          obscureText: false,
          keyboardType: TextInputType.phone,
          errorText: (ErrorBorders.errorTextPhoneNumber.isEmpty
              ? null
              : ErrorBorders.errorTextPhoneNumber),
          errorStyle: ErrorBorders.errorTextStyle,
          errorBorder: ErrorBorders.errorBorder,
          focusedErrorBorder: ErrorBorders.errorFocusedBorder,
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
            errorText: (ErrorBorders.errorTextPassword.isEmpty
                ? null
                : ErrorBorders.errorTextPassword),
            errorStyle: ErrorBorders.errorTextStylePassword,
            errorBorder: ErrorBorders.errorBorderPassword,
            focusedErrorBorder: ErrorBorders.errorFocusedBorderPassword,
          ),
        ),
        const Gap(30),
        LogSignButton(
          text: 'Sign Up',
          onTap: () {
            if (!finalValidation()) {}
          },
        ),
      ],
    );
  }
}

/*                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Text('Student Medium: '),
                                    RegistrationStudentMedium(),
                                  ],
                                ),
                                InputBox(
                                  textEditingController: _educationController,
                                  hintText: 'School/College Name',
                                  autoCorrect: false,
                                  enableSuggestions: false,
                                  obscureText: false,
                                  maxWidth: 350,
                                ),
                              ],
                            ),
                          ),
                          InputBox(
                            textEditingController: _studentDescController,
                            hintText: 'Self-Description',
                            autoCorrect: false,
                            enableSuggestions: false,
                            obscureText: false,
                            maxWidth: 600,
                            maxLength: 100,
                            maxLines: null,
                          ), */
