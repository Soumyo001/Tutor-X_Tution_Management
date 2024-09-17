// ignore_for_file: use_build_context_synchronously

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tutor_x_tution_management/utils/color_pallete.dart';
import 'package:tutor_x_tution_management/components/input_box.dart';
import 'package:tutor_x_tution_management/components/login_signup_button.dart';
import 'package:tutor_x_tution_management/components/social_button.dart';
import 'package:tutor_x_tution_management/controllers/nav_option_index_controller.dart';
import 'package:tutor_x_tution_management/helpers/loading/loading_helper.dart';
import 'package:tutor_x_tution_management/service/auth/auth_exceptions.dart';
import 'package:tutor_x_tution_management/service/auth/auth_service.dart';
import 'package:tutor_x_tution_management/utils/dialogs/error_dialog.dart';

class LoginPage extends StatefulWidget {
  final void Function() togglePage;
  const LoginPage({super.key, required this.togglePage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailEditingController;
  late final TextEditingController _passwordEditingController;
  late final NavIndexController _navIndexController;
  RxBool isPasswrodVisible = false.obs;

  @override
  void initState() {
    super.initState();
    _navIndexController = Get.find<NavIndexController>();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  void _loginWithEmailPassword() async {
    LoadingHelper().show(context, 'Loading...');
    try {
      if (_emailEditingController.text.isEmpty &&
          _passwordEditingController.text.isEmpty) {
        throw const GenericException(code: 'One or more field is required');
      }
      await AuthService.fromFirebase().logIn(
          email: _emailEditingController.text,
          password: _passwordEditingController.text);

      await _navIndexController.saveNavigationIndex(0);

      LoadingHelper().close();
    } on UserNotLoggedInException catch (e) {
      LoadingHelper().close();
      await showErrorDialog(context, e.code);
    } on GenericException catch (e) {
      LoadingHelper().close();
      await showErrorDialog(context, e.code);
    } catch (e) {
      LoadingHelper().close();
      await showErrorDialog(
          context, 'Not from own class exceptions: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Pallete.gradiant1, Pallete.gradiant3],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: currentSize / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.w200,
                            ),
                            child: AnimatedTextKit(
                              pause: const Duration(milliseconds: 250),
                              repeatForever: true,
                              animatedTexts: [
                                RotateAnimatedText(
                                  'Welcome User!',
                                  alignment: Alignment.center,
                                ),
                                RotateAnimatedText(
                                  'You\'ve been missed',
                                  alignment: Alignment.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.network(
                            'https://lottie.host/ac73cae1-5b19-42d2-a346-8206be8f61c5/pv8i2EcrQo.json',
                            width: 200,
                            height: 150,
                          ),
                          const Text(
                            'User Login',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const Gap(30),
                          InputBox(
                            textEditingController: _emailEditingController,
                            hintText: 'E-mail',
                            autoCorrect: false,
                            enableSuggestions: false,
                            obscureText: false,
                          ),
                          const Gap(20),
                          Obx(
                            () => InputBox(
                              textEditingController: _passwordEditingController,
                              hintText: 'Password',
                              autoCorrect: false,
                              enableSuggestions: false,
                              obscureText:
                                  isPasswrodVisible.value ? false : true,
                              suffixIcon: InkWell(
                                onTap: () {
                                  isPasswrodVisible.value =
                                      !isPasswrodVisible.value;
                                },
                                child: Icon(
                                  isPasswrodVisible.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: const Text(
                                    'Forgot Password?',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(30),
                          LogSignButton(
                            text: 'Sign In',
                            onTap: _loginWithEmailPassword,
                          ),
                          const Gap(40),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 0.5,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    'Or continue with',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 0.5,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(30),
                          SocialButton(
                            iconPath: 'lib/assets/icons/google.svg',
                            socialText: 'Sign in with Google',
                            onPressed: () {},
                            horizontalPadding: 90,
                          ),
                          const Gap(12),
                          SocialButton(
                            iconPath: 'lib/assets/icons/facebook.svg',
                            socialText: 'Sign in with Facebook',
                            horizontalPadding: 80,
                            onPressed: () {},
                          ),
                          const Gap(40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              const Gap(5),
                              GestureDetector(
                                onTap: widget.togglePage,
                                child: const Text(
                                  'Register here',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
