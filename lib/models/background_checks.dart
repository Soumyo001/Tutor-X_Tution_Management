import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

class BackgroundChecks {
  late int checkId;
  late int tutorId;
  late TutorBackgroundCheckType tutorBackgroundCheckType;
  late DateTime checkedDate;
  late VerificationStatus result;

  BackgroundChecks({
    required this.checkId,
    required this.tutorId,
    required this.tutorBackgroundCheckType,
    required this.checkedDate,
    required this.result,
  });

  BackgroundChecks.fromJson(Map<String, Object?> json) {
    checkId = json[backgroundCheckIdColumn] as int;
    tutorId = json[tutorIdColumn] as int;
    tutorBackgroundCheckType = json[backgroundTutorBackgroundCheckedTypeColumn]
        as TutorBackgroundCheckType;
    checkedDate = json[backgroundCheckDateColumn] as DateTime;
    result = json[backgroundCheckResultColumn] as VerificationStatus;
  }

  Map<String, Object?> toJson() => {
        backgroundCheckIdColumn: checkId,
        tutorIdColumn: tutorId,
        backgroundTutorBackgroundCheckedTypeColumn: tutorBackgroundCheckType,
        backgroundCheckDateColumn: checkedDate,
        backgroundCheckResultColumn: result,
      };
}
