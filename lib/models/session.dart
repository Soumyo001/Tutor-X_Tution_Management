import 'package:tutor_x_tution_management/data/enums.dart';

import 'package:tutor_x_tution_management/utils/constants.dart';

class Session {
  late int sessionId;
  late int studentId;
  late int tutorId;
  late String startDate;
  late String endDate;
  late String duration;
  late SessionStatus sessionStatus;

  Session({
    required this.sessionId,
    required this.studentId,
    required this.tutorId,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.sessionStatus,
  });

  Session.fromJson(Map<String, Object?> json) {
    sessionId = json[sessionIdColumn] as int;
    studentId = json[studentIdColumn] as int;
    tutorId = json[tutorIdColumn] as int;
    startDate = json[sessionStartDateColumn] as String;
    endDate = json[sessionEndDateColumn] as String;
    duration = json[sessionDurationColumn] as String;
    sessionStatus = json[sessionStatusColumn] as SessionStatus;
  }

  Map<String, Object?> toJson() => {
        sessionIdColumn: sessionId,
        studentIdColumn: studentId,
        tutorIdColumn: tutorId,
        sessionStartDateColumn: startDate,
        sessionEndDateColumn: endDate,
        sessionDurationColumn: duration,
        sessionStatusColumn: sessionStatus,
      };
}
