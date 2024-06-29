import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tutor_x_tution_management/color_pallete.dart';
import 'package:tutor_x_tution_management/components/input_box.dart';
import 'package:tutor_x_tution_management/components/social_button.dart';

class LoginPage extends StatefulWidget {
  final void Function() togglePage;
  const LoginPage({
    super.key,
    required this.togglePage,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailEditingController;
  late final TextEditingController _passwordEditingController;
  RxBool isPasswrodVisible = false.obs;

  @override
  void initState() {
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
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
                    width: currentWidth / 2,
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
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: currentWidth / 2,
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
                        const Gap(5),
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
                            obscureText: isPasswrodVisible.value ? false : true,
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
                        Container(
                          padding: const EdgeInsets.all(18),
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [Pallete.gradiant3, Pallete.gradiant2],
                            ),
                          ),
                          child: const Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
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
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
