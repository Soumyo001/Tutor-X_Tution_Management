import 'dart:convert';

import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/models/payment.dart';
import 'package:tutor_x_tution_management/models/student.dart';
import 'package:tutor_x_tution_management/models/tutor.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

class Session {
  late int sessionId;
  late int studentId;
  late int tutorId;
  late String startDate;
  late String endDate;
  late String duration;
  late SessionStatus sessionStatus;
  late Student student;
  late Tutor tutor;
  late Payment payment;

  Session({
    required this.sessionId,
    required this.studentId,
    required this.tutorId,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.sessionStatus,
    required this.student,
    required this.tutor,
    required this.payment,
  });

  Session.fromJson(Map<String, Object?> json) {
    sessionId = json[sessionIdColumn] as int;
    studentId = json[studentIdColumn] as int;
    tutorId = json[tutorIdColumn] as int;
    startDate = json[sessionStartDateColumn] as String;
    endDate = json[sessionEndDateColumn] as String;
    duration = json[sessionDurationColumn] as String;
    sessionStatus = json[sessionStatusColumn] as SessionStatus;
    student =
        Student.fromJson(jsonDecode(json[sessionStudentColumn] as String));
    tutor = Tutor.fromJson(jsonDecode(json[sessionTutorColumn] as String));
    payment =
        Payment.fromJson(jsonDecode(json[sessionPaymentColumn] as String));
  }

  Map<String, Object?> toJson() => {
        sessionIdColumn: sessionId,
        studentIdColumn: studentId,
        tutorIdColumn: tutorId,
        sessionStartDateColumn: startDate,
        sessionEndDateColumn: endDate,
        sessionDurationColumn: duration,
        sessionStatusColumn: sessionStatus,
        sessionStudentColumn: student.toJson(),
        sessionTutorColumn: tutor.toJson(),
        sessionPaymentColumn: payment.toJson(),
      };
}
