import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tutor_x_tution_management/models/tutor_post.dart';
import 'package:tutor_x_tution_management/service/api/api_exceptions.dart';
import 'package:tutor_x_tution_management/utils/api_constants.dart';

import 'dart:developer' as dev;

import 'package:tutor_x_tution_management/utils/constants.dart';

class TutorPostApi {
  TutorPostApi._sharedInstance();
  static final _shared = TutorPostApi._sharedInstance();
  factory TutorPostApi() => _shared;

  Future<List<TutorPost>> getAllTutorPost() async {
    List<TutorPost> tutorPosts = [];
    final uri = Uri.parse("$baseUrl/$tutorPostRoute");
    dev.log(uri.toString());
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        tutorPosts = jsonData.map((e) => TutorPost.fromJson(e)).toList();
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      dev.log('this problem from get all tutor post ${e.toString()}');
      throw ApiGenericException(code: e.toString());
    }
    return tutorPosts;
  }

  Future<TutorPost?> getTutorPostById(int tutorPostId) async {
    late TutorPost? tutorPost;
    final uri = Uri.parse("$baseUrl/$tutorPostRoute/$tutorPostId");
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        tutorPost = TutorPost.fromJson(jsonData);
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      dev.log('this problem from tutor post by id ${e.toString()}');
      throw ApiGenericException(code: e.toString());
    }
    return tutorPost;
  }

  Future<List<TutorPost>> getTutorPostsByFilter(
    String? location,
    int? studentMediumIndex,
    int? subjectTypeIndex,
    int? studentTypeIndex,
  ) async {
    List<TutorPost> tutorPosts = [];
    final Map<String, String> queryParameters = {};
    if (location != null) {
      queryParameters[tutorPostLocationColumn] = location;
    }
    if (studentMediumIndex != null) {
      queryParameters[tutorPostStudentMediumColumn] =
          studentMediumIndex.toString();
    }
    if (subjectTypeIndex != null) {
      queryParameters[tutorPostSubjectOfInterestColumn] =
          subjectTypeIndex.toString();
    }
    if (studentTypeIndex != null) {
      queryParameters[tutorPostExpectedStudentColumn] =
          studentTypeIndex.toString();
    }
    final uri = Uri.parse("$baseUrl/$tutorPostRoute")
        .replace(queryParameters: queryParameters);

    dev.log('from tutor post by filer function :\n ${uri.toString()}');
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        tutorPosts = jsonData.map((e) => TutorPost.fromJson(e)).toList();
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      dev.log('this problem from tutor post by filter ${e.toString()}');
      throw ApiGenericException(code: e.toString());
    }
    return tutorPosts;
  }

  Future<http.Response> postTutorPost({
    Map<String, dynamic> requestBody = const {},
  }) async {
    final uri = Uri.parse("$baseUrl/$tutorPostRoute");
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

  Future<http.Response> updateTutorPost({
    required int tutorPostId,
    Map<String, dynamic> body = const {},
  }) async {
    final uri = Uri.parse("$baseUrl/$tutorPostRoute/$tutorPostId");
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

  Future<http.Response> deleteTutorPost(int tutorPostId) async {
    final uri = Uri.parse("$baseUrl/$tutorPostRoute/$tutorPostId");
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
