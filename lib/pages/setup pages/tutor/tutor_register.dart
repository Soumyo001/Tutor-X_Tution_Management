// ignore_for_file: use_build_context_synchronously

import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/components/error_borders.dart';
import 'package:tutor_x_tution_management/components/input_box.dart';
import 'package:tutor_x_tution_management/components/login_signup_button.dart';
import 'package:tutor_x_tution_management/components/registration_tutor_profession_type.dart';
import 'package:tutor_x_tution_management/helpers/loading/loading_helper.dart';
import 'package:tutor_x_tution_management/helpers/validator/email_validator.dart';
import 'package:tutor_x_tution_management/helpers/validator/generic_validator.dart';
import 'package:tutor_x_tution_management/helpers/validator/pass_validator.dart';
import 'package:tutor_x_tution_management/helpers/validator/phone_number_validator.dart';
import 'package:tutor_x_tution_management/pages/setup%20pages/tutor/tutor_setup_walkthrough.dart';
import 'package:tutor_x_tution_management/service/auth/auth_exceptions.dart';
import 'package:tutor_x_tution_management/service/auth/auth_service.dart';
import 'package:tutor_x_tution_management/utils/dialogs/error_dialog.dart';

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
  late final TextEditingController _confirmPass;
  final RxBool isPasswrodVisible = false.obs;
  RxBool isConfirmPasswrodVisible = false.obs;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    _phoneController = TextEditingController();
    _confirmPass = TextEditingController();
  }

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
        ErrorBorders.errorTextStylePassword = TextStyle(
          color: Colors.red.shade900,
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

  bool finalValidatino() {
    int flag1 = 0, flag2 = 0, flag3 = 0, flag4 = 0;
    setState(() {
      if (!GenericValidator().validate(_fullNameController.text)) {
        ErrorBorders.errorTextFullName = 'This Field is Required';
        flag1 = 1;
      } else {
        ErrorBorders.errorTextFullName = '';
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

  Future<bool> _createWithEmailPassword() async {
    LoadingHelper().show(context, 'Loading...');
    try {
      await AuthService.fromFirebase().createUser(
        email: _emailEditingController.text,
        password: _passwordEditingController.text,
        confirmPassword: _confirmPass.text,
        phone: _phoneController.text,
      );
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
        InputBox(
          textEditingController: _fullNameController,
          hintText: 'Full Name',
          autoCorrect: false,
          enableSuggestions: false,
          obscureText: false,
          fontSize: 14,
          errorText: (ErrorBorders.errorTextFullName.isEmpty
              ? null
              : ErrorBorders.errorTextFullName),
          errorStyle: ErrorBorders.errorTextStyle,
          errorBorder: ErrorBorders.errorBorder,
          focusedErrorBorder: ErrorBorders.errorFocusedBorder,
        ),
        const Gap(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const TutorProfessionType(),
            InputBox(
              textEditingController: _phoneController,
              hintText: 'Phone Number',
              autoCorrect: false,
              enableSuggestions: false,
              onChanged: onPhoneNumberChange,
              obscureText: false,
              maxWidth: 190,
              keyboardType: TextInputType.number,
              errorText: (ErrorBorders.errorTextPhoneNumber.isEmpty
                  ? null
                  : ErrorBorders.errorTextPhoneNumber),
              errorStyle: ErrorBorders.errorTextStyle,
              errorBorder: ErrorBorders.errorBorder,
              focusedErrorBorder: ErrorBorders.errorFocusedBorder,
            ),
          ],
        ),
        const Gap(5),
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
            if (!finalValidatino()) {
              if (await _createWithEmailPassword()) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TutorSetupWalk(
                      phoneNumber: _phoneController.text,
                      fullName: _fullNameController.text,
                      email: _emailEditingController.text,
                      password: _passwordEditingController.text,
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
