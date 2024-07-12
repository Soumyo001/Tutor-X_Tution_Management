import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tutor_x_tution_management/models/messege.dart';
import 'package:tutor_x_tution_management/service/api/api_exceptions.dart';
import 'package:tutor_x_tution_management/utils/api_constants.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

class MessegeApi {
  MessegeApi._sharedInstance();
  static final _shared = MessegeApi._sharedInstance();
  factory MessegeApi() => _shared;

  Future<List<Messege>> getAllMesseges() async {
    List<Messege> messeges = [];
    final uri = Uri.parse("$baseUrl/$messegesRoute");
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        messeges = jsonData.map((e) => Messege.fromJson(e)).toList();
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      throw ApiGenericException(code: e.toString());
    }
    return messeges;
  }

  Future<Messege?> getMessegewById(int messegeId) async {
    late Messege? messege;
    final uri = Uri.parse("$baseUrl/$messegesRoute/$messegeId");
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        messege = Messege.fromJson(jsonData);
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      throw ApiGenericException(code: e.toString());
    }
    return messege;
  }

  Future<List<Messege>> getMessegeByStudentId(int studentId) async {
    List<Messege> messeges = [];
    final uri =
        Uri.parse("$baseUrl/$messegesRoute?$studentIdColumn=$studentId");
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        messeges = jsonData.map((e) => Messege.fromJson(e)).toList();
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      throw ApiGenericException(code: e.toString());
    }
    return messeges;
  }

  Future<List<Messege>> getMessegeByTutorId(int tutorId) async {
    List<Messege> messeges = [];
    final uri = Uri.parse("$baseUrl/$messegesRoute?$tutorIdColumn=$tutorId");
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        messeges = jsonData.map((e) => Messege.fromJson(e)).toList();
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      throw ApiGenericException(code: e.toString());
    }
    return messeges;
  }

  Future<List<Messege>> getMessegeByStudentAndTutorId(
      int studentId, int tutorId) async {
    List<Messege> messeges = [];
    final uri = Uri.parse(
        "$baseUrl/$messegesRoute?$studentIdColumn=$studentId&$tutorIdColumn=$tutorId");
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        messeges = jsonData.map((e) => Messege.fromJson(e)).toList();
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      throw ApiGenericException(code: e.toString());
    }
    return messeges;
  }

  Future<http.Response> postMessege({
    Map<String, dynamic> requestBody = const {},
  }) async {
    final uri = Uri.parse("$baseUrl/$messegesRoute");
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

  Future<http.Response> updateMessege({
    required int messegeId,
    Map<String, dynamic> body = const {},
  }) async {
    final uri = Uri.parse("$baseUrl/$messegesRoute/$messegeId");
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

  Future<http.Response> deleteMessege(int messegeId) async {
    final uri = Uri.parse("$baseUrl/$messegesRoute/$messegeId");
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
