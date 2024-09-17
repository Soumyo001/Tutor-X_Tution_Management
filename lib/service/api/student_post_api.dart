import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tutor_x_tution_management/models/student_post.dart';
import 'package:tutor_x_tution_management/service/api/api_exceptions.dart';
import 'package:tutor_x_tution_management/utils/api_constants.dart';

import 'dart:developer' as dev;

import 'package:tutor_x_tution_management/utils/constants.dart';

class StudentPostApi {
  StudentPostApi._sharedInstance();
  static final _shared = StudentPostApi._sharedInstance();
  factory StudentPostApi() => _shared;

  Future<List<StudentPost>> getAllStudentPosts() async {
    List<StudentPost> studentPosts = [];
    final uri = Uri.parse("$baseUrl/$studentPostRoute");
    dev.log('reached ${uri.toString()}');
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        studentPosts = jsonData.map((e) => StudentPost.fromJson(e)).toList();
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      dev.log('this problem from student post ${e.toString()}');
      throw ApiGenericException(code: e.toString());
    }
    return studentPosts;
  }

  Future<StudentPost?> getStudentPostById(int studentPostId) async {
    late StudentPost? studentPost;
    final uri = Uri.parse("$baseUrl/$studentPostRoute/$studentPostId");
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        studentPost = StudentPost.fromJson(jsonData);
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      dev.log('this problem from student post by Id${e.toString()}');
      throw ApiGenericException(code: e.toString());
    }
    return studentPost;
  }

  Future<List<StudentPost>> getStudentPostsByFilter(
    int? studentId,
    String? location,
    int? studentMediumIndex,
    int? studentTypeIndex,
    int? subjectTypeIndex,
  ) async {
    List<StudentPost> studentPosts = [];
    final Map<String, String> queryParams = {};
    if (studentId != null) {
      queryParams[studentIdColumn] = studentId.toString();
    }
    if (location != null) {
      queryParams[studentPostLocationColumn] = location;
    }
    if (studentMediumIndex != null) {
      queryParams[studentPostStudentMediumColumn] =
          studentMediumIndex.toString();
    }
    if (studentTypeIndex != null) {
      queryParams[studentPostStudentTypesColumn] = studentTypeIndex.toString();
    }
    if (subjectTypeIndex != null) {
      queryParams[studentPostSubjectTypesColumn] = subjectTypeIndex.toString();
    }
    final uri = Uri.parse('$baseUrl/$studentPostRoute').replace(
      queryParameters: queryParams,
    );

    dev.log('from student post by filer function : ${uri.toString()}');

    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        studentPosts = jsonData.map((e) => StudentPost.fromJson(e)).toList();
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      dev.log('this problem from student post by filter ${e.toString()}');
      throw ApiGenericException(code: e.toString());
    }
    return studentPosts;
  }

  Future<http.Response> postStudentPost({
    Map<String, dynamic> requestBody = const {},
  }) async {
    final uri = Uri.parse("$baseUrl/$studentPostRoute");
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

  Future<http.Response> updateStudentPost({
    required int studentPostId,
    Map<String, dynamic> body = const {},
  }) async {
    final uri = Uri.parse("$baseUrl/$studentPostRoute/$studentPostId");
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

  Future<http.Response> deleteStudentPost(int studentPostId) async {
    final uri = Uri.parse("$baseUrl/$studentPostRoute/$studentPostId");
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
