import 'dart:convert';

import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/models/messege.dart';
import 'package:tutor_x_tution_management/models/report.dart';
import 'package:tutor_x_tution_management/models/request.dart';
import 'package:tutor_x_tution_management/models/session.dart';
import 'package:tutor_x_tution_management/models/student_review.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

class Student {
  late int studentId;
  late int userId;
  late String firstName;
  late String lastName;
  late StudentMedium studentMedium;
  late String studentSelfDescription;
  late Session session;
  late List<StudentReview>? studentReviews;
  late List<Request>? requests;
  late List<Report>? reports;
  late List<Messege>? messeges;

  Student({
    required this.studentId,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.studentMedium,
    required this.studentSelfDescription,
    required this.session,
    this.studentReviews,
    this.requests,
    this.reports,
    this.messeges,
  });

  Student.fromJson(Map<String, Object?> json) {
    studentId = json[studentIdColumn] as int;
    userId = json[userIdColumn] as int;
    firstName = json[studentFirstNameColumn] as String;
    lastName = json[studentLastNameColumn] as String;
    studentMedium = json[studentMediumColumn] as StudentMedium;
    studentSelfDescription = json[studentSelfDescriptionColumn] as String;
    session =
        Session.fromJson(jsonDecode(json[studentSessionColumn] as String));
    if ((json[studentReviewListColumn] as String).isNotEmpty) {
      studentReviews = [];
      final List<dynamic> studentReviewList =
          jsonDecode(json[studentReviewListColumn] as String);
      for (final studentReview in studentReviewList) {
        studentReviews!.add(StudentReview.fromJson(studentReview));
      }
    }
    if ((json[requestListColumn] as String).isNotEmpty) {
      requests = [];
      final List<dynamic> requestList =
          jsonDecode(json[requestListColumn] as String);
      for (final request in requestList) {
        requests!.add(Request.fromJson(request));
      }
    }
    if ((json[reportListColumn] as String).isNotEmpty) {
      reports = [];
      final List<dynamic> reportList =
          jsonDecode(json[reportListColumn] as String);
      for (final report in reportList) {
        reports!.add(Report.fromJson(report));
      }
    }
    if ((json[messegeListColumn] as String).isNotEmpty) {
      messeges = [];
      final List<dynamic> messegeList =
          jsonDecode(json[messegeListColumn] as String);
      for (final messege in messegeList) {
        messeges!.add(Messege.fromJson(messege));
      }
    }
  }

  Map<String, Object?> toJson() => {
        studentIdColumn: studentId,
        userIdColumn: userId,
        studentFirstNameColumn: firstName,
        studentLastNameColumn: lastName,
        studentMediumColumn: studentMedium,
        studentSelfDescriptionColumn: studentSelfDescription,
        studentSessionColumn: session.toJson(),
        studentReviewListColumn:
            List<dynamic>.from(studentReviews!.map((e) => e.toJson())),
        requestListColumn: List<dynamic>.from(requests!.map((e) => e.toJson())),
        reportListColumn: List<dynamic>.from(reports!.map((e) => e.toJson())),
        messegeListColumn: List<dynamic>.from(messeges!.map((e) => e.toJson())),
      };
}
