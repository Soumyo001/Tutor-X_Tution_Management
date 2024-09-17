import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tutor_x_tution_management/models/report.dart';
import 'package:tutor_x_tution_management/service/api/api_exceptions.dart';
import 'package:tutor_x_tution_management/utils/api_constants.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

class ReportApi {
  ReportApi._sharedInstance();
  static final _shared = ReportApi._sharedInstance();
  factory ReportApi() => _shared;

  Future<List<Report>> getAllReports() async {
    List<Report> reports = [];
    final uri = Uri.parse("$baseUrl/$reportsRoute");
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        reports = jsonData.map((e) => Report.fromJson(e)).toList();
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      throw ApiGenericException(code: e.toString());
    }
    return reports;
  }

  Future<Report?> getReportById(int reportId) async {
    late Report? report;
    final uri = Uri.parse("$baseUrl/$reportsRoute/$reportId");
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        report = Report.fromJson(jsonData);
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      throw ApiGenericException(code: e.toString());
    }
    return report;
  }

  Future<List<Report>> getReportByUidFrom(int uidFrom) async {
    List<Report> reports = [];
    final uri =
        Uri.parse("$baseUrl/$reportsRoute?$reportUidFromColumn=$uidFrom");
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        reports = jsonData.map((e) => Report.fromJson(e)).toList();
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      throw ApiGenericException(code: e.toString());
    }
    return reports;
  }

  Future<List<Report>> getReportByUidTo(int uidTo) async {
    List<Report> reports = [];
    final uri = Uri.parse("$baseUrl/$reportsRoute?$reportUidToColumn=$uidTo");
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        reports = jsonData.map((e) => Report.fromJson(e)).toList();
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      throw ApiGenericException(code: e.toString());
    }
    return reports;
  }

  Future<List<Report>> getReportsByBothParties(int uidFrom, int uidTo) async {
    List<Report> reports = [];
    final uri = Uri.parse(
        "$baseUrl/$reportsRoute?$reportUidFromColumn=$uidFrom&$reportUidToColumn=$uidTo");
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        reports = jsonData.map((e) => Report.fromJson(e)).toList();
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      throw ApiGenericException(code: e.toString());
    }
    return reports;
  }

  Future<http.Response> postReport({
    Map<String, dynamic> requestBody = const {},
  }) async {
    final uri = Uri.parse("$baseUrl/$reportsRoute");
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

  Future<http.Response> updateReport({
    required int reportId,
    Map<String, dynamic> body = const {},
  }) async {
    final uri = Uri.parse("$baseUrl/$reportsRoute/$reportId");
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

  Future<http.Response> deleteReport(int reportId) async {
    final uri = Uri.parse("$baseUrl/$reportsRoute/$reportId");
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
