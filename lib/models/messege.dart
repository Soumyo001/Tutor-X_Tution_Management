import 'package:tutor_x_tution_management/utils/constants.dart';

class Messege {
  late String messegeId;
  late int uidFrom;
  late int uidTo;
  late String messegeText;
  late DateTime timeStamp;

  Messege({
    required this.messegeId,
    required this.uidFrom,
    required this.uidTo,
    required this.messegeText,
    required this.timeStamp,
  });

  Messege.fromJson(Map<String, Object?> json) {
    messegeId = json[messegeIdColumn] as String;
    uidFrom = json[messegeUidFromColumn] as int;
    uidTo = json[messegeUidToColumn] as int;
    messegeText = json[messegeTextColumn] as String;
    timeStamp = json[messegeTimeStampColumn] as DateTime;
  }

  Map<String, Object?> toJson() => {
        messegeIdColumn: messegeId,
        messegeUidFromColumn: uidFrom,
        messegeUidToColumn: uidTo,
        messegeTextColumn: messegeText,
        messegeTimeStampColumn: timeStamp,
      };
}
