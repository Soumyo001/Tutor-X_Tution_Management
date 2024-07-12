import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';

@immutable
class AuthUser {
  final bool isEmailVerified;
  final String? email;
  final String? userName;
  const AuthUser({
    required this.isEmailVerified,
    required this.email,
    required this.userName,
  });
  factory AuthUser.fromFirebase(User user) => AuthUser(
        isEmailVerified: user.emailVerified,
        email: user.email,
        userName: user.displayName,
      );
}
