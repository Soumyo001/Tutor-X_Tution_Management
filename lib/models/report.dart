import 'package:tutor_x_tution_management/utils/constants.dart';

class Report {
  late int reportId;
  late int studentId;
  late int tutorId;
  late String reportText;
  late String reportDate;

  Report({
    required this.reportId,
    required this.studentId,
    required this.tutorId,
    required this.reportText,
    required this.reportDate,
  });

  Report.fromJson(Map<String, Object?> json) {
    reportId = json[reportIdColumn] as int;
    studentId = json[studentIdColumn] as int;
    tutorId = json[tutorIdColumn] as int;
    reportText = json[reportTextColumn] as String;
    reportDate = json[reportDateColumn] as String;
  }

  Map<String, Object?> toJson() => {
        reportIdColumn: reportId,
        studentIdColumn: studentId,
        tutorIdColumn: tutorId,
        reportTextColumn: reportText,
        reportDateColumn: reportDate,
      };
}
