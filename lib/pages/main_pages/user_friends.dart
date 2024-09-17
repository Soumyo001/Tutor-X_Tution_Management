// ignore_for_file: use_build_context_synchronously

import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/components/friend_profile_display_widget.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'package:tutor_x_tution_management/controllers/user_friends_controller.dart';
import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/models/request.dart';
import 'package:tutor_x_tution_management/models/student.dart';
import 'package:tutor_x_tution_management/models/tutor.dart';
import 'package:tutor_x_tution_management/models/user.dart';
import 'package:tutor_x_tution_management/routes/route.dart';
import 'package:tutor_x_tution_management/service/api/request_api.dart';
import 'package:tutor_x_tution_management/service/api/student_api.dart';
import 'package:tutor_x_tution_management/service/api/tutor_api.dart';
import 'package:tutor_x_tution_management/service/api/user_api.dart';
import 'package:tutor_x_tution_management/utils/dialogs/confirmation_dialog.dart';
import 'package:tutor_x_tution_management/utils/dialogs/error_dialog.dart';

class UserFriends extends StatefulWidget {
  const UserFriends({super.key});

  @override
  State<UserFriends> createState() => _UserFriendsState();
}

class _UserFriendsState extends State<UserFriends> {
  late final UserStaticsController _userStaticsController;
  late final UserFriendsController _userFriendsController;
  @override
  void initState() {
    super.initState();
    _userStaticsController = Get.find<UserStaticsController>();
    _userFriendsController = Get.find<UserFriendsController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Friends',
                    style: TextStyle(fontSize: 40, color: Colors.black87),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Divider(
                color: Colors.grey.shade400,
                height: 0.5,
              ),
            ),
            const Gap(15),
            Obx(
              () => FutureBuilder(
                future: RequestApi().getUserFriends(
                    _userStaticsController.userId,
                    friends: true),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    _userFriendsController.friends =
                        snapshot.data as List<Request>;
                    if (_userFriendsController.friends.isNotEmpty) {
                      return Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: _userFriendsController.friends.length,
                          itemBuilder: (context, index) {
                            final r = _userFriendsController.friends[index];
                            return FutureBuilder(
                              future: UserApi().getUserById(
                                  r.uidFrom == _userStaticsController.userId
                                      ? r.uidTo
                                      : r.uidFrom),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  final user = snapshot.data as User;
                                  if (user.userType == UserCategory.teacher) {
                                    return FutureBuilder(
                                      future: TutorApi()
                                          .getTutorByUserId(user.userId),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          final tutor =
                                              snapshot.data as List<Tutor>;
                                          return Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: InkWell(
                                              onTap: () {
                                                Get.toNamed(
                                                  WebRoutes
                                                      .otherTutorProfilePage,
                                                  arguments: {
                                                    'tutor_data': tutor.first,
                                                    'user_data': user,
                                                  },
                                                );
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: FriendDisplayWidget(
                                                imageData:
                                                    tutor.first.imageData,
                                                fullName: user.fullName,
                                                education: user.education,
                                                onPressed: () async {
                                                  final approval =
                                                      await showConfirmationDialog(
                                                    context,
                                                    'Remove Friend ?',
                                                    acceptString: 'Yes',
                                                    declineString: 'No',
                                                  );
                                                  if (approval) {
                                                    final request = await RequestApi()
                                                        .getRequestByBothParties(
                                                            r.uidFrom,
                                                            _userStaticsController
                                                                .userId);
                                                    final response =
                                                        await RequestApi()
                                                            .deleteRequest(
                                                                request.first
                                                                    .requestId);
                                                    if (!(response.statusCode >=
                                                            200 &&
                                                        response.statusCode <=
                                                            299)) {
                                                      await showErrorDialog(
                                                          context,
                                                          'There was a problem removing friend');
                                                    } else {
                                                      _userFriendsController
                                                          .friends
                                                          .removeWhere((element) =>
                                                              element
                                                                  .requestId ==
                                                              request.first
                                                                  .requestId);
                                                    }
                                                  }
                                                },
                                              ),
                                            ),
                                          );
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      },
                                    );
                                  } else {
                                    return FutureBuilder(
                                      future: StudentApi()
                                          .getStudentByUserId(user.userId),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          final student =
                                              snapshot.data as List<Student>;
                                          return Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: InkWell(
                                              onTap: () {
                                                Get.toNamed(
                                                  WebRoutes
                                                      .otherStudentProfilePage,
                                                  arguments: {
                                                    'student_data':
                                                        student.first,
                                                    'user_data': user,
                                                  },
                                                );
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: FriendDisplayWidget(
                                                imageData:
                                                    student.first.imageData,
                                                fullName: user.fullName,
                                                education: user.education,
                                                onPressed: () async {
                                                  final approval =
                                                      await showConfirmationDialog(
                                                          context,
                                                          'Remove Friend ?');
                                                  if (approval) {
                                                    final request = await RequestApi()
                                                        .getRequestByBothParties(
                                                            r.uidFrom,
                                                            _userStaticsController
                                                                .userId);
                                                    final response =
                                                        await RequestApi()
                                                            .deleteRequest(
                                                                request.first
                                                                    .requestId);
                                                    if (!(response.statusCode >=
                                                            200 &&
                                                        response.statusCode <=
                                                            299)) {
                                                      await showErrorDialog(
                                                          context,
                                                          'There was a problem removing friend');
                                                    } else {
                                                      _userFriendsController
                                                          .friends
                                                          .removeWhere((element) =>
                                                              element
                                                                  .requestId ==
                                                              request.first
                                                                  .requestId);
                                                    }
                                                  }
                                                },
                                              ),
                                            ),
                                          );
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      },
                                    );
                                  }
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          'You currently don\'t have any friends...'
                              .toUpperCase(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 3,
                          ),
                        ),
                      );
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
