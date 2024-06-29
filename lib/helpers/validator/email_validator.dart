class EmailValidator {
  EmailValidator._sharedInstance();
  static final _shared = EmailValidator._sharedInstance();
  factory EmailValidator() => _shared;
  final RegExp emailPattern = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  bool validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return emailPattern.hasMatch(value);
  }
}
