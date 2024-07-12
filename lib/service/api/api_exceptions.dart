class ApiGenericException implements Exception {
  final String code;
  ApiGenericException({required this.code});
}

class ApiClientException implements Exception {}
