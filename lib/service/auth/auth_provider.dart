import 'package:tutor_x_tution_management/service/auth/auth_user.dart';

abstract class CustomAuthProvider {
  Future<void> initializeApp();
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });
  AuthUser? get currentUser;
  Future<AuthUser> createUser({
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  });
  Future<void> logOut();
  Future<void> sendEmailverification();
  Future<void> reload();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> deleteAccount();
  Stream<AuthUser?> onUserChanges();
  bool isLoggedIn();
}
