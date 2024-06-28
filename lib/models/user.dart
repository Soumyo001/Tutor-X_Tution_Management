import 'dart:convert';
import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/models/resource.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

class User {
  late int userId;
  late String fullName;
  late String phoneNumber;
  late String email;
  late String password;
  late String education;
  late String location;
  late UserCategory userType;
  late List<Resource>? resources;

  User({
    required this.userId,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.education,
    required this.location,
    required this.userType,
    this.resources,
  });

  User.fromJson(Map<String, Object?> json) {
    userId = json[userIdColumn] as int;
    fullName = json[fullNameColumn] as String;
    phoneNumber = json[phoneNumberColumn] as String;
    email = json[emailColumn] as String;
    password = json[passwordColumn] as String;
    education = json[educationColumn] as String;
    location = json[locationColumn] as String;
    userType = json[userTypeColumn] as UserCategory;
    if ((json[resourceListColumn] as String).isNotEmpty) {
      resources = [];
      final List<dynamic> resourceList =
          jsonDecode(json[resourceListColumn] as String);
      for (final resource in resourceList) {
        resources!.add(Resource.fromJson(resource));
      }
    }
  }

  Map<String, Object?> toJson() => {
        userIdColumn: userId,
        fullNameColumn: fullName,
        phoneNumberColumn: phoneNumber,
        emailColumn: email,
        passwordColumn: password,
        educationColumn: education,
        locationColumn: location,
        userTypeColumn: userType,
        resourceListColumn:
            List<dynamic>.from(resources!.map((e) => e.toJson())),
      };
}
