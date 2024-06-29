import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tutor_x_tution_management/color_pallete.dart';
import 'package:tutor_x_tution_management/components/registraion_user_categort.dart';
import 'package:tutor_x_tution_management/components/social_button.dart';
import 'package:tutor_x_tution_management/controllers/enum_controller.dart';
import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/pages/setup_pages/student/student_setup.dart';
import 'package:tutor_x_tution_management/pages/setup_pages/tutor/tutor_setup.dart';

class RegisterPage extends StatefulWidget {
  final void Function() togglePage;
  const RegisterPage({
    super.key,
    required this.togglePage,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final EnumController enumController = Provider.of<EnumController>(context);
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
                                TypewriterAnimatedText(
                                  'Register Here',
                                  speed: const Duration(milliseconds: 150),
                                ),
                                RotateAnimatedText(
                                  'Join The Community',
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
                        const Text(
                          'User Registration',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const RegistrationUserCategory(),
                        enumController.userCategory == UserCategory.student
                            ? const StudentRegistrationForm()
                            : const TutorRegistrationForm(),
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
                            'Sign Up',
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
                              'Already have an account?',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                            ),
                            const Gap(5),
                            GestureDetector(
                              onTap: widget.togglePage,
                              child: const Text(
                                'Login here',
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