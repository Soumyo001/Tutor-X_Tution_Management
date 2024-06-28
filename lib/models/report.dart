import 'dart:convert';

import 'package:tutor_x_tution_management/models/student.dart';
import 'package:tutor_x_tution_management/models/tutor.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

class Report {
  late int reportId;
  late int studentId;
  late int tutorId;
  late String reportText;
  late String reportDate;
  late Student student;
  late Tutor tutor;

  Report({
    required this.reportId,
    required this.studentId,
    required this.tutorId,
    required this.reportText,
    required this.reportDate,
    required this.student,
    required this.tutor,
  });

  Report.fromJson(Map<String, Object?> json) {
    reportId = json[reportIdColumn] as int;
    studentId = json[studentIdColumn] as int;
    tutorId = json[tutorIdColumn] as int;
    reportText = json[reportTextColumn] as String;
    reportDate = json[reportDateColumn] as String;
    student = Student.fromJson(jsonDecode(json[reportStudentColumn] as String));
    tutor = Tutor.fromJson(jsonDecode(json[reportTutorColumn] as String));
  }

  Map<String, Object?> toJson() => {
        reportIdColumn: reportId,
        studentIdColumn: studentId,
        tutorIdColumn: tutorId,
        reportTextColumn: reportText,
        reportDateColumn: reportDate,
        reportStudentColumn: student.toJson(),
        reportTutorColumn: tutor.toJson(),
      };
}
