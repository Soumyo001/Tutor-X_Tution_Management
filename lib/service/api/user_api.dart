import 'dart:async';
import 'dart:convert';

import 'package:tutor_x_tution_management/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_x_tution_management/service/api/api_exceptions.dart';
import 'dart:developer' as dev;
import 'package:tutor_x_tution_management/utils/api_constants.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

class UserApi {
  UserApi._sharedInstance();
  static final _shared = UserApi._sharedInstance();
  factory UserApi() => _shared;

  Future<List<User>> getAllUserData() async {
    List<User> userData = [];
    final uri = Uri.parse("$baseUrl/$userRoute");
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        userData = jsonData.map((e) => User.fromJson(e)).toList();
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      throw ApiGenericException(code: e.toString());
    }
    return userData;
  }

  Future<User?> getUserById(int userId) async {
    late User? user;
    final uri = Uri.parse("$baseUrl/$userRoute/$userId");
    dev.log(uri.toString());
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        user = User.fromJson(jsonData);
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      dev.log(e.toString());
      throw ApiGenericException(code: e.toString());
    }
    return user;
  }

  Future<List<User>> getUserByEmail(String email) async {
    List<User> userData = [];
    final uri = Uri.parse("$baseUrl/$userRoute?$userEmailColumn=$email");
    dev.log(uri.toString());
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        userData = jsonData.map((e) => User.fromJson(e)).toList();
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      dev.log(e.toString());
      throw ApiGenericException(code: e.toString());
    }
    return userData;
  }

  Future<http.Response> postUser({
    Map<String, dynamic> requestBody = const {},
  }) async {
    final uri = Uri.parse("$baseUrl/$userRoute");
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

  Future<http.Response> updateUser({
    required int userId,
    Map<String, dynamic> body = const {},
  }) async {
    final uri = Uri.parse("$baseUrl/$userRoute/$userId");
    try {
      final response = http.put(
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

  Future<http.Response> deleteUser(int userId) async {
    final uri = Uri.parse("$baseUrl/$userRoute/$userId");
    try {
      final response = http.delete(
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
