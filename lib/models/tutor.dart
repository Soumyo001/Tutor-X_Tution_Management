import 'dart:convert';

import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/models/background_checks.dart';
import 'package:tutor_x_tution_management/models/messege.dart';
import 'package:tutor_x_tution_management/models/report.dart';
import 'package:tutor_x_tution_management/models/request.dart';
import 'package:tutor_x_tution_management/models/session.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

class Tutor {
  late int tutorId;
  late int userId;
  late AvailabilityStatus status;
  late StudentMedium mediumOfInterest;
  late StudentTypes expectedStudent;
  late SubjectTypes subjectOfInterest;
  late int expectedSalary;
  late ProfessionType profession;
  late VerificationStatus verificationStatus;
  late String tutorSelfDescription;
  late BackgroundChecks backgroundChecks;
  late List<Session>? sessions;
  late List<Request>? requests;
  late List<Report>? reports;
  late List<Messege>? messeges;

  Tutor({
    required this.tutorId,
    required this.userId,
    required this.status,
    required this.mediumOfInterest,
    required this.expectedStudent,
    required this.subjectOfInterest,
    required this.expectedSalary,
    required this.profession,
    required this.verificationStatus,
    required this.tutorSelfDescription,
    required this.backgroundChecks,
    this.sessions,
    this.requests,
    this.reports,
    this.messeges,
  });

  Tutor.fromJson(Map<String, Object?> json) {
    tutorId = json[tutorIdColumn] as int;
    userId = json[userIdColumn] as int;
    status = json[tutorAvailabilityStatusColumn] as AvailabilityStatus;
    mediumOfInterest = json[tutorMediumOfInterestColumn] as StudentMedium;
    expectedStudent = json[tutorExpectedStudentColumn] as StudentTypes;
    subjectOfInterest = json[tutorSubjectOfInterestColumn] as SubjectTypes;
    expectedSalary = json[tutorExpectedSalaryColumn] as int;
    profession = json[tutorProfessionColumn] as ProfessionType;
    verificationStatus = json[tutorVerificationColumn] as VerificationStatus;
    tutorSelfDescription = json[tutorSelfDescriptionColumn] as String;
    backgroundChecks = BackgroundChecks.fromJson(
        jsonDecode(json[tutorBackgroundCheckColumn] as String));
    if ((json[tutorSessionsListColumn] as String).isNotEmpty) {
      sessions = [];
      final List<dynamic> sessionList =
          jsonDecode(json[tutorSessionsListColumn] as String);
      for (final session in sessionList) {
        sessions!.add(Session.fromJson(session));
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
        tutorIdColumn: tutorId,
        userIdColumn: userId,
        tutorAvailabilityStatusColumn: status,
        tutorMediumOfInterestColumn: mediumOfInterest,
        tutorExpectedStudentColumn: expectedStudent,
        tutorSubjectOfInterestColumn: subjectOfInterest,
        tutorExpectedSalaryColumn: expectedSalary,
        tutorProfessionColumn: profession,
        tutorVerificationColumn: verificationStatus,
        tutorSelfDescriptionColumn: tutorSelfDescription,
        tutorBackgroundCheckColumn: backgroundChecks.toJson(),
        tutorSessionsListColumn:
            List<dynamic>.from(sessions!.map((e) => e.toJson())),
        requestListColumn: List<dynamic>.from(requests!.map((e) => e.toJson())),
        reportListColumn: List<dynamic>.from(reports!.map((e) => e.toJson())),
        messegeListColumn: List<dynamic>.from(messeges!.map((e) => e.toJson())),
      };
}
