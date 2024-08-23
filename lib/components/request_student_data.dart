import 'package:flutter/Material.dart';
import 'package:tutor_x_tution_management/components/request_display.dart';
import 'package:tutor_x_tution_management/models/request.dart';
import 'package:tutor_x_tution_management/models/student.dart';
import 'package:tutor_x_tution_management/models/user.dart';
import 'package:tutor_x_tution_management/service/api/student_api.dart';

class RequestStudentData extends StatefulWidget {
  final Request r;
  final User user;
  final void Function()? onAccept;
  final void Function()? onDecline;
  const RequestStudentData(
      {super.key,
      required this.r,
      required this.user,
      required this.onAccept,
      required this.onDecline});

  @override
  State<RequestStudentData> createState() => _RequestStudentDataState();
}

class _RequestStudentDataState extends State<RequestStudentData> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StudentApi().getStudentByUserId(widget.r.uidFrom),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final student = snapshot.data as List<Student>;
          return RequestDisplay(
            education: widget.user.education,
            fullName: widget.user.fullName,
            imageData: student.first.imageData,
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
