// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/components/error_borders.dart';
import 'package:tutor_x_tution_management/components/input_box.dart';
import 'package:tutor_x_tution_management/components/login_signup_button.dart';
import 'package:tutor_x_tution_management/controllers/nav_option_index_controller.dart';
import 'package:tutor_x_tution_management/helpers/loading/loading_helper.dart';
import 'package:tutor_x_tution_management/helpers/validator/email_validator.dart';
import 'package:tutor_x_tution_management/helpers/validator/generic_validator.dart';
import 'package:tutor_x_tution_management/helpers/validator/pass_validator.dart';
import 'package:tutor_x_tution_management/helpers/validator/phone_number_validator.dart';
import 'package:tutor_x_tution_management/pages/setup%20pages/student/student_setup_walkthrough.dart';
import 'package:tutor_x_tution_management/service/auth/auth_exceptions.dart';
import 'package:tutor_x_tution_management/service/auth/auth_service.dart';
import 'package:tutor_x_tution_management/utils/dialogs/error_dialog.dart';

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
  late final TextEditingController _confirmPass;
  late final NavIndexController _navIndexController;
  RxBool isPasswrodVisible = false.obs;
  RxBool isConfirmPasswrodVisible = false.obs;

  void _onEmailChange(String value) {
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

  void _onPasswordChange(String value) {
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

  void _onConfirmPassChange(String value) {
    if (_passwordEditingController.text != value && value.isNotEmpty) {
      setState(
        () {
          ErrorBorders.errorTextPasswordC = 'Passwords doesn\'t match';
          ErrorBorders.errorTextStylePasswordC = TextStyle(
            color: Colors.red.shade900,
          );
          ErrorBorders.errorBorderPasswordC = OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.redAccent.shade200.withOpacity(0.8),
            ),
          );
          ErrorBorders.errorFocusedBorderPasswordC = OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.red.shade900,
            ),
          );
        },
      );
    } else {
      setState(() {
        ErrorBorders.errorTextPasswordC = '';
      });
    }
  }

  void _onPhoneNumberChange(String value) {
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
    _confirmPass = TextEditingController();
    _navIndexController = Get.find<NavIndexController>();
  }

  Future<bool> _createWithEmailPassword() async {
    LoadingHelper().show(context, 'Loading...');
    try {
      await AuthService.fromFirebase().createUser(
        email: _emailEditingController.text,
        password: _passwordEditingController.text,
        confirmPassword: _confirmPass.text,
        phone: _phoneController.text,
      );
      await _navIndexController.saveNavigationIndex(0);
      LoadingHelper().close();
      final user = AuthService.fromFirebase().currentUser;
      if (user != null) {
        // await AuthService.fromFirebase().reload();
        // if (!user.isEmailVerified) {
        //   await AuthService.fromFirebase().sendEmailverification();
        // }
      }
      return true;
    } on UserNotLoggedInException catch (e) {
      LoadingHelper().close();
      await showErrorDialog(context, e.code);
      return false;
    } on GenericException catch (e) {
      LoadingHelper().close();
      await showErrorDialog(context, e.code);
      return false;
    } catch (e) {
      LoadingHelper().close();
      await showErrorDialog(
          context, 'Not from own class exceptions: ${e.toString()}');

      return false;
    }
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
                maxWidth: 180, // currentSize.width / 2 / 5.311,
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
                maxWidth: 180, //currentSize.width / 2 / 5.311
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
          onChanged: _onEmailChange,
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
          onChanged: _onPhoneNumberChange,
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
            onChanged: _onPasswordChange,
            errorText: (ErrorBorders.errorTextPassword.isEmpty
                ? null
                : ErrorBorders.errorTextPassword),
            errorStyle: ErrorBorders.errorTextStylePassword,
            errorBorder: ErrorBorders.errorBorderPassword,
            focusedErrorBorder: ErrorBorders.errorFocusedBorderPassword,
          ),
        ),
        const Gap(10),
        Obx(
          () => InputBox(
            textEditingController: _confirmPass,
            hintText: 'Confirm Password',
            autoCorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.visiblePassword,
            obscureText: isConfirmPasswrodVisible.value,
            fontSize: 14,
            suffixIcon: InkWell(
              onTap: () {
                isConfirmPasswrodVisible.value =
                    !isConfirmPasswrodVisible.value;
              },
              child: Icon(
                isConfirmPasswrodVisible.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.black,
              ),
            ),
            onChanged: _onConfirmPassChange,
            errorText: (ErrorBorders.errorTextPasswordC.isEmpty
                ? null
                : ErrorBorders.errorTextPasswordC),
            errorStyle: ErrorBorders.errorTextStylePasswordC,
            errorBorder: ErrorBorders.errorBorderPasswordC,
            focusedErrorBorder: ErrorBorders.errorFocusedBorderPasswordC,
          ),
        ),
        const Gap(20),
        LogSignButton(
          text: 'Sign Up',
          onTap: () async {
            if (!finalValidation()) {
              if (await _createWithEmailPassword()) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => StudentWalk(
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      email: _emailEditingController.text,
                      password: _passwordEditingController.text,
                      phoneNumber: _phoneController.text,
                    ),
                  ),
                );
              }
            }
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
