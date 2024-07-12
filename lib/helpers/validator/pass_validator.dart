class PasswordValidator {
  PasswordValidator._sharedInstance();
  static final _shared = PasswordValidator._sharedInstance();
  factory PasswordValidator() => _shared;

  final RegExp _passPattern = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,}$',
    caseSensitive: false,
    multiLine: false,
  );

  bool validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return _passPattern.hasMatch(value);
  }
}
