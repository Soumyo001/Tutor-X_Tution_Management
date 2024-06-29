class GenericValidator {
  GenericValidator._sharedInstance();
  static final _shared = GenericValidator._sharedInstance();
  factory GenericValidator() => _shared;
  bool validate(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return true;
  }
}
