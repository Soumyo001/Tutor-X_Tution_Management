class PhoneValidator {
  PhoneValidator._sharedInstance();
  static final _shared = PhoneValidator._sharedInstance();
  factory PhoneValidator() => _shared;
  final RegExp _numberPattern = RegExp(r'^(?:\+?88|0088)?01[15-9]\d{8}$');
  bool validate(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return _numberPattern.hasMatch(value);
  }
}
