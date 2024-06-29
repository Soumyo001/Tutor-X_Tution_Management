import 'package:flutter/material.dart';
import 'package:tutor_x_tution_management/pages/login_page.dart';
import 'package:tutor_x_tution_management/pages/register_page.dart';

class LoginRegisterView extends StatefulWidget {
  const LoginRegisterView({super.key});

  @override
  State<LoginRegisterView> createState() => _LoginRegisterViewState();
}

class _LoginRegisterViewState extends State<LoginRegisterView> {
  bool isLoginPage = true;

  void togglePage() {
    setState(() {
      isLoginPage = !isLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoginPage) {
      return LoginPage(togglePage: togglePage);
    } else {
      return RegisterPage(togglePage: togglePage);
    }
  }
}
