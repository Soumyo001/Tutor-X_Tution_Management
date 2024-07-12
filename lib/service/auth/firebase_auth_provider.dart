import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutor_x_tution_management/firebase_options.dart';
import 'package:tutor_x_tution_management/helpers/validator/email_validator.dart';
import 'package:tutor_x_tution_management/helpers/validator/pass_validator.dart';
import 'package:tutor_x_tution_management/helpers/validator/phone_number_validator.dart';
import 'package:tutor_x_tution_management/service/auth/auth_exceptions.dart';
import 'package:tutor_x_tution_management/service/auth/auth_provider.dart';

import 'package:tutor_x_tution_management/service/auth/auth_user.dart';

class FirebaseAuthProvider implements CustomAuthProvider {
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) async {
    try {
      if (email.isEmpty && password.isEmpty) {
        throw const GenericException(code: 'Email or Password field empty');
      }
      if (!EmailValidator().validateEmail(email)) {
        throw const GenericException(code: 'invalid email');
      }
      if (!PasswordValidator().validatePassword(password)) {
        throw const GenericException(code: 'weak password');
      }
      if (!PhoneValidator().validate(phone)) {
        throw const GenericException(code: 'Invalid Phone number');
      }
      if (password != confirmPassword) {
        throw const GenericException(code: 'Password Mismatch');
      }
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw const UserNotLoggedInException();
      }
    } on FirebaseAuthException catch (e) {
      throw GenericException(code: e.code);
    } on UserNotLoggedInException {
      throw const UserNotLoggedInException();
    } on GenericException catch (e) {
      throw GenericException(code: e.code);
    } catch (e) {
      throw GenericException(code: e.toString());
    }
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw const UserNotLoggedInException();
      }
    } on FirebaseAuthException catch (e) {
      throw GenericException(code: e.code);
    } catch (e) {
      throw GenericException(code: e.toString());
    }
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw const UserNotLoggedInException();
    }
  }

  @override
  Future<void> sendEmailverification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw const UserNotLoggedInException();
    }
  }

  @override
  Future<void> initializeApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<void> reload() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
    } else {
      throw const UserNotLoggedInException();
    }
  }

  @override
  Stream<AuthUser?> onUserChanges() async* {
    await for (var user in FirebaseAuth.instance.userChanges()) {
      if (user == null) {
        yield null;
      } else {
        yield AuthUser.fromFirebase(user);
      }
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> deleteAccount() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
      await user.delete();
    } else {
      throw CouldNotDeleteAccountException();
    }
  }

  @override
  bool isLoggedIn() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    } else {
      return true;
    }
  }
}
