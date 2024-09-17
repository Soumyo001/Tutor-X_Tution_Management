import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

class User {
  late int userId;
  late String fullName;
  late String phoneNumber;
  late String email;
  late String password;
  late String education;
  late String location;
  late int userReports;
  late UserCategory userType;

  User({
    required this.userId,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.education,
    required this.location,
    required this.userType,
    required this.userReports,
  });

  User.fromJson(Map<String, Object?> json) {
    userId = json[userIdColumn] as int;
    fullName = json[fullNameColumn] as String;
    phoneNumber = json[phoneNumberColumn] as String;
    email = json[userEmailColumn] as String;
    password = json[userPasswordColumn] as String;
    education = json[userEducationColumn] as String;
    location = json[userLocationColumn] as String;
    userReports = json[userReportsColumn] as int;
    userType = UserCategory.values[json[userTypeColumn] as int];
  }

  Map<String, Object?> toJson() => {
        userIdColumn: userId,
        fullNameColumn: fullName,
        phoneNumberColumn: phoneNumber,
        userEmailColumn: email,
        userPasswordColumn: password,
        userEducationColumn: education,
        userLocationColumn: location,
        userReportsColumn: userReports,
        userTypeColumn: userType.index,
      };
}
