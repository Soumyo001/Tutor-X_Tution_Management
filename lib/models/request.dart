import 'package:tutor_x_tution_management/data/enums.dart';

import 'package:tutor_x_tution_management/utils/constants.dart';

class Request {
  late int requestId;
  late int studentId;
  late int tutorId;
  late String requestDate;
  late bool isFromTutor;
  late RequestStatus requestStatus;

  Request({
    required this.requestId,
    required this.studentId,
    required this.tutorId,
    required this.requestDate,
    required this.isFromTutor,
    required this.requestStatus,
  });

  Request.fromJson(Map<String, Object?> json) {
    requestId = json[requestIdColumn] as int;
    studentId = json[studentIdColumn] as int;
    tutorId = json[tutorIdColumn] as int;
    requestDate = json[requestDateColumn] as String;
    isFromTutor = json[isrequestFromTutorColumn] as bool;
    requestStatus = json[requestStatusColumn] as RequestStatus;
  }

  Map<String, Object?> toJson() => {
        requestIdColumn: requestId,
        studentIdColumn: studentId,
        tutorIdColumn: tutorId,
        requestDateColumn: requestDate,
        isrequestFromTutorColumn: isFromTutor,
        requestStatusColumn: requestStatus,
      };
}
