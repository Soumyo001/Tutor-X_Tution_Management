import 'package:flutter/Material.dart';
import 'package:tutor_x_tution_management/components/request_display.dart';
import 'package:tutor_x_tution_management/models/request.dart';
import 'package:tutor_x_tution_management/models/tutor.dart';
import 'package:tutor_x_tution_management/models/user.dart';
import 'package:tutor_x_tution_management/service/api/tutor_api.dart';

class RequestTutorData extends StatefulWidget {
  final Request r;
  final User user;
  final void Function()? onAccept;
  final void Function()? onDecline;
  const RequestTutorData(
      {super.key,
      required this.r,
      required this.user,
      required this.onAccept,
      required this.onDecline});

  @override
  State<RequestTutorData> createState() => _RequestTutorDataState();
}

class _RequestTutorDataState extends State<RequestTutorData> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TutorApi().getTutorByUserId(widget.r.uidFrom),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final tutor = snapshot.data as List<Tutor>;
          return RequestDisplay(
            education: widget.user.education,
            fullName: widget.user.fullName,
            imageData: tutor.first.imageData,
            onAccept: widget.onAccept,
            onDecline: widget.onDecline,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
