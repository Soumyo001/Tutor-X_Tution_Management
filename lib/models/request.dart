import 'dart:convert';

import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/models/student.dart';
import 'package:tutor_x_tution_management/models/tutor.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

class Request {
  late int requestId;
  late int studentId;
  late int tutorId;
  late String requestDate;
  late bool isFromTutor;
  late RequestStatus requestStatus;
  late Student student;
  late Tutor tutor;

  Request({
    required this.requestId,
    required this.studentId,
    required this.tutorId,
    required this.requestDate,
    required this.isFromTutor,
    required this.requestStatus,
    required this.student,
    required this.tutor,
  });

  Request.fromJson(Map<String, Object?> json) {
    requestId = json[requestIdColumn] as int;
    studentId = json[studentIdColumn] as int;
    tutorId = json[tutorIdColumn] as int;
    requestDate = json[requestDateColumn] as String;
    isFromTutor = json[isrequestFromTutorColumn] as bool;
    requestStatus = json[requestStatusColumn] as RequestStatus;
    student =
        Student.fromJson(jsonDecode(json[requestStudentColumn] as String));
    tutor = Tutor.fromJson(jsonDecode(json[requestTutorColumn] as String));
  }

  Map<String, Object?> toJson() => {
        requestIdColumn: requestId,
        studentIdColumn: studentId,
        tutorIdColumn: tutorId,
        requestDateColumn: requestDate,
        isrequestFromTutorColumn: isFromTutor,
        requestStatusColumn: requestStatus,
        requestStudentColumn: student.toJson(),
        requestTutorColumn: tutor.toJson(),
      };
}
