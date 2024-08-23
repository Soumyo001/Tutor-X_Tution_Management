// ignore_for_file: use_build_context_synchronously

import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/components/request_student_data.dart';
import 'package:tutor_x_tution_management/components/request_tutor_data.dart';
import 'package:tutor_x_tution_management/controllers/request_controller.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/models/request.dart';
import 'package:tutor_x_tution_management/models/user.dart';
import 'package:tutor_x_tution_management/pages/navigation_bar/navigation_panel.dart';
import 'package:tutor_x_tution_management/service/api/request_api.dart';
import 'package:tutor_x_tution_management/service/api/user_api.dart';
import 'package:tutor_x_tution_management/utils/dialogs/confirmation_dialog.dart';
import 'package:tutor_x_tution_management/utils/dialogs/error_dialog.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  late final UserStaticsController _userStaticsController;
  late final RequestController _requestController;

  @override
  void initState() {
    super.initState();
    _userStaticsController = Get.find<UserStaticsController>();
    _requestController = Get.find<RequestController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NavigationPanel(),
          const Gap(18),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Freind Invitations',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          const Gap(15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              height: 0.2,
              color: Colors.grey.shade400,
            ),
          ),
          const Gap(15),
          Obx(
            () => FutureBuilder(
              future: RequestApi()
                  .getRequestByUserIdTo(_userStaticsController.userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  _requestController.requests = snapshot.data as List<Request>;
                  if (_requestController.requests.isNotEmpty) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: _requestController.requests.length,
                      itemBuilder: (context, index) {
                        final r = _requestController.requests[index];
                        return FutureBuilder(
                          future: UserApi().getUserById(r.uidFrom),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              final user = snapshot.data as User;
                              if (r.isFromTutor) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: RequestTutorData(
                                    r: r,
                                    user: user,
                                    onAccept: () async {
                                      final request = await RequestApi()
                                          .getRequestByBothParties(
                                              r.uidFrom, r.uidTo);
                                      if (request.isNotEmpty) {
                                        request.first.requestStatus =
                                            RequestStatus.accept;
                                        request.first.requestDate =
                                            DateTime.now().toString();
                                        final response =
                                            await RequestApi().updateRequest(
                                          requestId: request.first.requestId,
                                          body: request.first.toJson(),
                                        );
                                        if (!(response.statusCode >= 200 &&
                                            response.statusCode <= 299)) {
                                          await showErrorDialog(context,
                                              'There was a problem accepting your friend request');
                                        }
                                      } else {
                                        await showErrorDialog(context,
                                            'Could not find friend request');
                                      }
                                    },
                                    onDecline: () async {
                                      final result =
                                          await showConfirmationDialog(context,
                                              'Cancel Friend Request ?');
                                      if (result) {
                                        final request = await RequestApi()
                                            .getRequestByBothParties(
                                                r.uidFrom, r.uidTo);
                                        if (request.isNotEmpty) {
                                          request.first.requestStatus =
                                              RequestStatus.decline;
                                          await RequestApi().deleteRequest(
                                              request.first.requestId);
                                        }
                                      }
                                    },
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: RequestStudentData(
                                    r: r,
                                    user: user,
                                    onAccept: () async {
                                      final request = await RequestApi()
                                          .getRequestByBothParties(
                                              r.uidFrom, r.uidTo);
                                      if (request.isNotEmpty) {
                                        request.first.requestStatus =
                                            RequestStatus.accept;
                                        request.first.requestDate =
                                            DateTime.now().toString();
                                        final response =
                                            await RequestApi().updateRequest(
                                          requestId: request.first.requestId,
                                          body: request.first.toJson(),
                                        );
                                        if (!(response.statusCode >= 200 &&
                                            response.statusCode <= 299)) {
                                          await showErrorDialog(context,
                                              'There was a problem accepting your friend request');
                                        }
                                      } else {
                                        await showErrorDialog(context,
                                            'Could not find friend request');
                                      }
                                    },
                                    onDecline: () async {
                                      final result =
                                          await showConfirmationDialog(context,
                                              'Cancel Friend Request ?');
                                      if (result) {
                                        final request = await RequestApi()
                                            .getRequestByBothParties(
                                                r.uidFrom, r.uidTo);
                                        if (request.isNotEmpty) {
                                          request.first.requestStatus =
                                              RequestStatus.decline;
                                          await RequestApi().deleteRequest(
                                              request.first.requestId);
                                        }
                                      }
                                    },
                                  ),
                                );
                              }
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        'It\'s quiet right now...'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 3,
                        ),
                      ),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
