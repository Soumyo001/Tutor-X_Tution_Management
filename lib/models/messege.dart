import 'package:tutor_x_tution_management/utils/constants.dart';

class Messege {
  late String messegeId;
  late int studentId;
  late int tutorId;
  late String messegeText;
  late DateTime timeStamp;

  Messege({
    required this.messegeId,
    required this.studentId,
    required this.tutorId,
    required this.messegeText,
    required this.timeStamp,
  });

  Messege.fromJson(Map<String, Object?> json) {
    messegeId = json[messegeIdColumn] as String;
    studentId = json[studentIdColumn] as int;
    tutorId = json[tutorIdColumn] as int;
    messegeText = json[messegeTextColumn] as String;
    timeStamp = json[messegeTimeStampColumn] as DateTime;
  }

  Map<String, Object?> toJson() => {
        messegeIdColumn: messegeId,
        studentIdColumn: studentId,
        tutorIdColumn: tutorId,
        messegeTextColumn: messegeText,
        messegeTimeStampColumn: timeStamp,
      };
}
