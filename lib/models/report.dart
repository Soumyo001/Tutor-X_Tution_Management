import 'package:tutor_x_tution_management/utils/constants.dart';

class Report {
  late int reportId;
  late int uidFrom;
  late int uidTo;
  late String reportText;
  late String reportDate;

  Report({
    required this.reportId,
    required this.uidFrom,
    required this.uidTo,
    required this.reportText,
    required this.reportDate,
  });

  Report.fromJson(Map<String, Object?> json) {
    reportId = json[reportIdColumn] as int;
    uidFrom = json[reportUidFromColumn] as int;
    uidTo = json[reportUidToColumn] as int;
    reportText = json[reportTextColumn] as String;
    reportDate = json[reportDateColumn] as String;
  }

  Map<String, Object?> toJson() => {
        reportIdColumn: reportId,
        reportUidFromColumn: uidFrom,
        reportUidToColumn: uidTo,
        reportTextColumn: reportText,
        reportDateColumn: reportDate,
      };
}
