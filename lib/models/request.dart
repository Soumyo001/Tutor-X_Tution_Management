import 'package:tutor_x_tution_management/data/enums.dart';

import 'package:tutor_x_tution_management/utils/constants.dart';

class Request {
  late int requestId;
  late int uidFrom;
  late int uidTo;
  late String requestDate;
  late bool isFromTutor;
  late RequestStatus requestStatus;

  Request({
    required this.requestId,
    required this.uidFrom,
    required this.uidTo,
    required this.requestDate,
    required this.isFromTutor,
    required this.requestStatus,
  });

  Request.fromJson(Map<String, Object?> json) {
    requestId = json[requestIdColumn] as int;
    uidFrom = json[requestuidFromColumn] as int;
    uidTo = json[requestuidToColumn] as int;
    requestDate = json[requestDateColumn] as String;
    isFromTutor = json[isrequestFromTutorColumn] as bool;
    requestStatus = RequestStatus.values[json[requestStatusColumn] as int];
  }

  Map<String, Object?> toJson() => {
        requestIdColumn: requestId,
        requestuidFromColumn: uidFrom,
        requestuidToColumn: uidTo,
        requestDateColumn: requestDate,
        isrequestFromTutorColumn: isFromTutor,
        requestStatusColumn: requestStatus.index,
      };
}
