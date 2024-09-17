import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/models/request.dart';
import 'package:tutor_x_tution_management/service/api/api_exceptions.dart';
import 'package:tutor_x_tution_management/utils/api_constants.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

class RequestApi {
  RequestApi._sharedInstance();
  static final _shared = RequestApi._sharedInstance();
  factory RequestApi() => _shared;

  Future<List<Request>> getAllRequest() async {
    List<Request> requests = [];
    final uri = Uri.parse("$baseUrl/$requestRoute");
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        requests = jsonData.map((e) => Request.fromJson(e)).toList();
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      throw ApiGenericException(code: e.toString());
    }
    return requests;
  }

  Future<Request?> getRequestById(int requestId) async {
    late Request? request;
    final uri = Uri.parse("$baseUrl/$requestRoute/$requestId");
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        request = Request.fromJson(jsonData);
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      throw ApiGenericException(code: e.toString());
    }
    return request;
  }

  Future<List<Request>> getRequestByUserIdFrom(int userId,
      {bool friends = false}) async {
    List<Request> requests = [];
    final uri =
        Uri.parse("$baseUrl/$requestRoute?$requestuidFromColumn=$userId");

    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        requests = jsonData.map((e) => Request.fromJson(e)).toList();
        if (friends) {
          requests = requests
              .where((element) => element.requestStatus == RequestStatus.accept)
              .toList();
        }
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      throw ApiGenericException(code: e.toString());
    }
    return requests;
  }

  Future<List<Request>> getRequestByUserIdTo(int userId,
      {bool friends = false}) async {
    List<Request> requests = [];
    final uri = Uri.parse("$baseUrl/$requestRoute?$requestuidToColumn=$userId");
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        requests = jsonData.map((e) => Request.fromJson(e)).toList();
        if (friends) {
          requests = requests
              .where((e) => e.requestStatus == RequestStatus.accept)
              .toList();
        } else {
          requests = requests
              .where((e) => e.requestStatus == RequestStatus.pending)
              .toList();
        }
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      throw ApiGenericException(code: e.toString());
    }
    return requests;
  }

  Future<List<Request>> getUserFriends(int uid, {required bool friends}) async {
    List<Request> requests = [];
    requests = (await getRequestByUserIdFrom(uid, friends: friends));
    requests.addAll((await getRequestByUserIdTo(uid, friends: friends)));
    return requests;
  }

  Future<List<Request>> getRequestByBothParties(int uidFrom, int uidTo) async {
    List<Request> requests = [];
    final uri = Uri.parse(
        "$baseUrl/$requestRoute?$requestuidFromColumn=$uidFrom&$requestuidToColumn=$uidTo");
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        requests = jsonData.map((e) => Request.fromJson(e)).toList();
      }
    } on http.ClientException {
      throw ApiClientException();
    } catch (e) {
      throw ApiGenericException(code: e.toString());
    }
    return requests;
  }

  Future<http.Response> sendRequest({
    Map<String, dynamic> requestBody = const {},
  }) async {
    final uri = Uri.parse("$baseUrl/$requestRoute");
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

  Future<http.Response> updateRequest({
    required int requestId,
    Map<String, dynamic> body = const {},
  }) async {
    final uri = Uri.parse("$baseUrl/$requestRoute/$requestId");
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

  Future<http.Response> deleteRequest(int requestId) async {
    final uri = Uri.parse("$baseUrl/$requestRoute/$requestId");
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
