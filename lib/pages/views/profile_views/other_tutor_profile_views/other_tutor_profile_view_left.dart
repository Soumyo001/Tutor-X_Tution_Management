// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/components/icon_button.dart';
import 'package:tutor_x_tution_management/components/input_box2.dart';
import 'package:tutor_x_tution_management/components/tutor_profile_info.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/models/report.dart';
import 'package:tutor_x_tution_management/models/request.dart';
import 'package:tutor_x_tution_management/models/tutor.dart';
import 'package:tutor_x_tution_management/models/user.dart';
import 'package:tutor_x_tution_management/routes/route.dart';
import 'package:tutor_x_tution_management/service/api/report_api.dart';
import 'package:tutor_x_tution_management/service/api/request_api.dart';
import 'package:tutor_x_tution_management/utils/dialogs/assuring_dialog.dart';
import 'package:tutor_x_tution_management/utils/dialogs/confirmation_dialog.dart';
import 'package:tutor_x_tution_management/utils/dialogs/error_dialog.dart';
import 'package:tutor_x_tution_management/utils/dialogs/success_dialog.dart';

class OtherTutorProfileViewPartLeft extends StatefulWidget {
  final User user;
  final Tutor tutor;
  const OtherTutorProfileViewPartLeft(
      {super.key, required this.tutor, required this.user});

  @override
  State<OtherTutorProfileViewPartLeft> createState() =>
      _OtherTutorProfileViewPartLeftState();
}

class _OtherTutorProfileViewPartLeftState
    extends State<OtherTutorProfileViewPartLeft> {
  late final UserStaticsController _userStaticsController;
  late final TextEditingController _contController;
  final RxBool reqSent = false.obs;
  final RxBool reqConfirmation = false.obs;
  final RxBool reqConfirmed = false.obs;

  @override
  void initState() {
    super.initState();
    _userStaticsController = Get.find<UserStaticsController>();
    _contController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchRequestData();
  }

  Future<void> fetchRequestData() async {
    final req = await RequestApi().getRequestByBothParties(
        _userStaticsController.userId, widget.tutor.userId);
    if (req.isNotEmpty) {
      if (req.first.requestStatus == RequestStatus.pending) {
        reqSent.value = true;
        reqConfirmation.value = false;
        reqConfirmed.value = false;
      } else if (req.first.requestStatus == RequestStatus.accept) {
        reqSent.value = false;
        reqConfirmation.value = false;
        reqConfirmed.value = true;
      }
    }
    final r = await RequestApi().getRequestByBothParties(
        widget.tutor.userId, _userStaticsController.userId);
    if (r.isNotEmpty) {
      print('${widget.tutor.userId}       ${_userStaticsController.userId}');
      if (r.first.requestStatus == RequestStatus.pending) {
        reqConfirmation.value = true;
        reqSent.value = false;
        reqConfirmed.value = false;
      } else if (r.first.requestStatus == RequestStatus.accept) {
        reqConfirmation.value = false;
        reqSent.value = false;
        reqConfirmed.value = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        height: screenSize.height,
        width: screenSize.width / 2,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500.withAlpha(150),
              blurRadius: 16,
              spreadRadius: 1,
              offset: const Offset(5, 5),
            ),
            BoxShadow(
              color: Colors.grey.shade500.withAlpha(150),
              blurRadius: 16,
              spreadRadius: 1,
              offset: const Offset(-5, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: screenSize.height * 0.53,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  widget.tutor.imageData == null
                      ? Image.asset(
                          'lib/assets/images/profile_placeholder.jpg',
                          fit: BoxFit.fitHeight,
                        )
                      : Image.memory(
                          base64Decode(widget.tutor.imageData!),
                          fit: BoxFit.fitHeight,
                        ),
                  LayoutBuilder(
                    builder: (context, constraints) => Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * 0.15,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.shade200.withAlpha(150),
                      ),
                      child: Text(
                        widget.user.fullName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonIcon(
                  label: 'Messege',
                  icon: Icons.message,
                  onPressed: () async {
                    Get.toNamed(
                      WebRoutes.messege,
                      arguments: {
                        'user': widget.user,
                        'tutor': widget.tutor,
                      },
                    );
                  },
                  enableIcon: true,
                  loading: false,
                ),
                Obx(
                  () => ButtonIcon(
                    label: reqSent.value == true
                        ? 'Invitation Sent'
                        : (reqConfirmation.value == true
                            ? 'Confirm'
                            : (reqConfirmed.value == true
                                ? 'Friends'
                                : 'Connect')),
                    icon: reqSent.value == true
                        ? Icons.arrow_right_alt_rounded
                        : (reqConfirmation.value == true
                            ? Icons.arrow_right_alt_rounded
                            : (reqConfirmed.value == true
                                ? Icons.person
                                : Icons.person_add_alt)),
                    onPressed: () async {
                      if (reqSent.value) {
                        final assure = await showAssuringDialog(context,
                            'Do you want to cancel your Friend Request ?');
                        if (assure) {
                          final req = await RequestApi()
                              .getRequestByBothParties(
                                  _userStaticsController.userId,
                                  widget.tutor.userId);
                          final response = await RequestApi()
                              .deleteRequest(req.first.requestId);
                          if (response.statusCode >= 200 &&
                              response.statusCode <= 299) {
                            reqSent.value = false;
                          } else {
                            await showErrorDialog(context,
                                'There was a problem canceling  your friend request');
                          }
                        }
                      } else if (reqConfirmation.value) {
                        final result = await showConfirmationDialog(
                            context, 'Accept Friend Request ?');
                        if (result) {
                          final r = await RequestApi().getRequestByBothParties(
                              widget.tutor.userId,
                              _userStaticsController.userId);
                          if (r.isNotEmpty) {
                            if (r.first.requestStatus ==
                                RequestStatus.pending) {
                              r.first.requestStatus = RequestStatus.accept;
                              r.first.requestDate = DateTime.now().toString();
                              final response = await RequestApi().updateRequest(
                                  requestId: r.first.requestId,
                                  body: r.first.toJson());
                              if (response.statusCode >= 200 &&
                                  response.statusCode <= 299) {
                                reqConfirmation.value = false;
                                reqConfirmed.value = true;
                              } else {
                                await showErrorDialog(context,
                                    'There was a problem accepting the friend request');
                              }
                            }
                          }
                          // final response = await RequestApi().updateRequest(
                          //     requestId: r.first.requestId,
                          //     body: r.first.toJson());
                          // if (response.statusCode >= 200 &&
                          //     response.statusCode <= 299) {
                          //   reqConfirmation.value = false;
                          //   reqConfirmed.value = true;
                          // } else {
                          //   await showErrorDialog(context,
                          //       'There was a problem accepting the friend request');
                          // }
                        } else {
                          final r = await RequestApi().getRequestByBothParties(
                              widget.tutor.userId,
                              _userStaticsController.userId);
                          if (r.isNotEmpty) {
                            final response = await RequestApi()
                                .deleteRequest(r.first.requestId);
                            if (response.statusCode >= 200 &&
                                response.statusCode <= 299) {
                              reqConfirmation.value = false;
                              reqConfirmed.value = false;
                              reqSent.value = false;
                            } else {
                              await showErrorDialog(context,
                                  'There was a problem deleting the friend request');
                            }
                          }
                        }
                      } else if (reqConfirmed.value) {
                        final result = await showConfirmationDialog(
                            context, 'Remove Friend ?',
                            acceptString: 'Yes', declineString: 'No');
                        if (result) {
                          var r = await RequestApi().getRequestByBothParties(
                              _userStaticsController.userId,
                              widget.tutor.userId);
                          if (r.isEmpty) {
                            r = await RequestApi().getRequestByBothParties(
                                widget.tutor.userId,
                                _userStaticsController.userId);
                          }
                          final response = await RequestApi()
                              .deleteRequest(r.first.requestId);
                          if (response.statusCode >= 200 &&
                              response.statusCode <= 299) {
                            reqConfirmed.value = false;
                            reqConfirmation.value = false;
                            reqSent.value = false;
                          } else {
                            await showErrorDialog(context,
                                'There was a problem removing your friend');
                          }
                        }
                      } else {
                        final request = Request(
                          requestId: 0,
                          uidFrom: _userStaticsController.userId,
                          uidTo: widget.tutor.userId,
                          requestDate: DateTime.now().toString(),
                          isFromTutor: (_userStaticsController.userCategory ==
                                  UserCategory.teacher
                              ? true
                              : false),
                          requestStatus: RequestStatus.pending,
                        );
                        final res = await RequestApi()
                            .sendRequest(requestBody: request.toJson());
                        if (res.statusCode >= 200 && res.statusCode <= 299) {
                          reqSent.value = true;
                        } else {
                          await showErrorDialog(context,
                              'There was a problem sending your request');
                        }
                      }
                    },
                    enableIcon: true,
                    loading: false,
                  ),
                ),
                ButtonIcon(
                  label: 'Report',
                  icon: Icons.report,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.report,
                                    size: 30,
                                  ),
                                  Gap(5),
                                  Text(
                                    'Report',
                                    style: TextStyle(fontSize: 28),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                splashRadius: 25,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                          content: SizedBox(
                            width: screenSize.width * 0.4,
                            height: screenSize.height * 0.25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InputBox2(
                                  hintText: 'Content',
                                  controller: _contController,
                                  alternativeColor: true,
                                  disableMaxLengthAndLines: false,
                                  maxLength: null,
                                  maxLines: 5,
                                ),
                                const Gap(15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ButtonIcon(
                                      icon: Icons.send,
                                      onPressed: () async {
                                        final report = Report(
                                          reportId: 0,
                                          uidFrom:
                                              _userStaticsController.userId,
                                          uidTo: widget.user.userId,
                                          reportText: _contController.text,
                                          reportDate: DateTime.now().toString(),
                                        );
                                        final response =
                                            await ReportApi().postReport(
                                          requestBody: report.toJson(),
                                        );
                                        if (response.statusCode >= 200 &&
                                            response.statusCode <= 299) {
                                          Navigator.of(context).pop();
                                          await showSuccessDialog(context,
                                              'Successfully Submitted');
                                        } else {
                                          await showErrorDialog(
                                              context, 'Something went wrong');
                                        }
                                      },
                                      enableIcon: true,
                                      loading: false,
                                      label: 'Submit',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  enableIcon: true,
                  loading: false,
                ),
              ],
            ),
            const Gap(15),
            SizedBox(
              height: screenSize.height * 0.4,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(
                        color: Colors.grey.shade500.withAlpha(150),
                        thickness: 0.5,
                        height: 0.5,
                      ),
                    ),
                    const Gap(15),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TutorProfileInfo(
                            info: widget.user.location,
                            icon: Icons.home,
                          ),
                          const Gap(15),
                          TutorProfileInfo(
                            info: widget.user.email,
                            icon: Icons.email,
                          ),
                          const Gap(15),
                          TutorProfileInfo(
                            info: widget.user.phoneNumber,
                            icon: Icons.phone,
                          ),
                          const Gap(15),
                          TutorProfileInfo(
                            info: widget.tutor.profession
                                .toString()
                                .split('.')
                                .last
                                .replaceAll('_', ' '),
                            icon: Icons.cases_outlined,
                          ),
                          const Gap(20),
                          TutorProfileInfo(
                            info: widget.user.education,
                            icon: Icons.school,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
