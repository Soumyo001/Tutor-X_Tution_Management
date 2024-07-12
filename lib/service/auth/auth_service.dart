import 'package:tutor_x_tution_management/service/auth/auth_provider.dart';
import 'package:tutor_x_tution_management/service/auth/auth_user.dart';
import 'package:tutor_x_tution_management/service/auth/firebase_auth_provider.dart';

class AuthService implements CustomAuthProvider {
  final CustomAuthProvider authProvider;
  const AuthService({required this.authProvider});
  factory AuthService.fromFirebase() =>
      AuthService(authProvider: FirebaseAuthProvider());

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) =>
      authProvider.createUser(
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          phone: phone);

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      authProvider.logIn(
        email: email,
        password: password,
      );

  @override
  AuthUser? get currentUser => authProvider.currentUser;

  @override
  Future<void> logOut() => authProvider.logOut();

  @override
  Future<void> sendEmailverification() => authProvider.sendEmailverification();

  @override
  Future<void> initializeApp() => authProvider.initializeApp();

  @override
  Future<void> reload() => authProvider.reload();

  @override
  Stream<AuthUser?> onUserChanges() => authProvider.onUserChanges();

  @override
  Future<void> sendPasswordResetEmail(String email) =>
      authProvider.sendPasswordResetEmail(email);

  @override
  Future<void> deleteAccount() => authProvider.deleteAccount();

  @override
  bool isLoggedIn() => authProvider.isLoggedIn();
}
