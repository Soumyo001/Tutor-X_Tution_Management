import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tutor_x_tution_management/models/resource.dart';
import 'package:tutor_x_tution_management/service/api/api_exceptions.dart';
import 'package:tutor_x_tution_management/utils/api_constants.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

class ResourceApi {
  ResourceApi._sharedInstance();
  static final _shared = ResourceApi._sharedInstance();
  factory ResourceApi() => _shared;

  Future<List<Resource>> getAllResource() async {
    List<Resource> resources = [];
    final uri = Uri.parse("$baseUrl/$resourceRoute");
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        resources = jsonData.map((e) => Resource.fromJson(e)).toList();
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      throw ApiGenericException(code: e.toString());
    }
    return resources;
  }

  Future<Resource?> getResourceById(int resourceId) async {
    late Resource? resource;
    final uri = Uri.parse("$baseUrl/$resourceRoute/$resourceId");
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final Map<String, dynamic> data = json.decode(response.body);
        resource = Resource.fromJson(data);
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      throw ApiGenericException(code: e.toString());
    }
    return resource;
  }

  Future<List<Resource>> getResourceByUserId(int userId) async {
    List<Resource> resources = [];
    final uri = Uri.parse("$baseUrl/$resourceRoute?$userIdColumn=$userId");
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        resources = jsonData.map((e) => Resource.fromJson(e)).toList();
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      throw ApiGenericException(code: e.toString());
    }
    return resources;
  }

  Future<http.Response> postResource({
    Map<String, dynamic> requestBody = const {},
  }) async {
    final uri = Uri.parse("$baseUrl/$resourceRoute");
    try {
      final response = await http.post(
        uri,
        headers: headers,
        body: json.encode(requestBody),
      );
      return response;
    } catch (e) {
      final responseBody = {
        "error": {"message": e.toString(), "code": 404}
      };
      final response = http.Response(
        jsonEncode(responseBody),
        500,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return response;
    }
  }

  Future<http.Response> updateResource({
    required int resourceId,
    Map<String, dynamic> body = const {},
  }) async {
    final uri = Uri.parse("$baseUrl/$resourceRoute/$resourceId");
    try {
      final response = await http.put(
        uri,
        headers: headers,
        body: json.encode(body),
      );
      return response;
    } catch (e) {
      final responseBody = {
        "error": {"message": e.toString(), "code": 404}
      };
      final response = http.Response(
        jsonEncode(responseBody),
        500,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return response;
    }
  }

  Future<http.Response> deleteResource(int resourceId) async {
    final uri = Uri.parse("$baseUrl/$resourceRoute/$resourceId");
    try {
      final response = await http.delete(
        uri,
        headers: headers,
      );
      return response;
    } catch (e) {
      final responseBody = {
        "error": {"message": e.toString(), "code": 404}
      };
      final response = http.Response(
        jsonEncode(responseBody),
        500,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return response;
    }
  }
}
