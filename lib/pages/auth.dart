import 'package:flutter/material.dart';
import 'package:tutor_x_tution_management/pages/login_register_view.dart';
import 'package:tutor_x_tution_management/pages/main_pages/pre_info_page.dart';
import 'package:tutor_x_tution_management/service/auth/auth_service.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService.fromFirebase().onUserChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const PreInfoPage();
        } else {
          return const LoginRegisterView();
        }
      },
    );
  }
}
