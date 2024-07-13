import 'dart:convert';

import 'package:tutor_x_tution_management/models/tutor.dart';
import 'package:tutor_x_tution_management/service/api/api_exceptions.dart';
import 'package:tutor_x_tution_management/utils/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_x_tution_management/utils/constants.dart';
import 'dart:developer' as dev;

class TutorApi {
  TutorApi._sharedInstance();
  static final _shared = TutorApi._sharedInstance();
  factory TutorApi() => _shared;

  Future<List<Tutor>> getAllTutor() async {
    List<Tutor> tutors = [];
    final uri = Uri.parse("$baseUrl/$tutorRoute");
    dev.log(uri.toString());
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        tutors = jsonData.map((e) => Tutor.fromJson(e)).toList();
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      dev.log('this problem from tutor ${e.toString()}');
      throw ApiGenericException(code: e.toString());
    }
    return tutors;
  }

  Future<Tutor?> getTutorById(int tutorId) async {
    late Tutor? tutor;
    final uri = Uri.parse("$baseUrl/$tutorRoute/$tutorId");
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        tutor = Tutor.fromJson(jsonData);
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      dev.log('this problem from tutor by id ${e.toString()}');
      throw ApiGenericException(code: e.toString());
    }
    return tutor;
  }

  Future<List<Tutor>> getTutorByUserId(int userId) async {
    List<Tutor> tutors = [];
    final uri = Uri.parse("$baseUrl/$tutorRoute?$userIdColumn=$userId");
    dev.log(uri.toString());
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        tutors = jsonData.map((e) => Tutor.fromJson(e)).toList();
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      dev.log('get tutor by userID : ${e.toString()}');
      throw ApiGenericException(code: e.toString());
    }
    return tutors;
  }

  Future<http.Response> postTutor({
    Map<String, dynamic> requestBody = const {},
  }) async {
    final uri = Uri.parse("$baseUrl/$tutorRoute");
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

  Future<http.Response> updateTutor({
    required int tutorId,
    Map<String, dynamic> body = const {},
  }) async {
    final uri = Uri.parse("$baseUrl/$tutorRoute/$tutorId");
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

  Future<http.Response> deleteTutor(int tutorId) async {
    final uri = Uri.parse("$baseUrl/$tutorRoute/$tutorId");
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
