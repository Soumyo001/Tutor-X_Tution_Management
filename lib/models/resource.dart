import 'dart:convert';

import 'package:tutor_x_tution_management/models/user.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

class Resource {
  late int resourceId;
  late int userId;
  late String resourceTitle;
  late String resourceDescription;
  late String resourceUrl;
  late String resourceUploadDate;
  late User user;

  Resource({
    required this.resourceId,
    required this.userId,
    required this.resourceTitle,
    required this.resourceDescription,
    required this.resourceUrl,
    required this.resourceUploadDate,
    required this.user,
  });

  Resource.fromJson(Map<String, Object?> json) {
    resourceId = json[resourceIdColumn] as int;
    userId = json[userIdColumn] as int;
    resourceTitle = json[resourceTitleColumn] as String;
    resourceDescription = json[resourceDescriptionColumn] as String;
    resourceUrl = json[resourceUrlColumn] as String;
    resourceUploadDate = json[resourceUploadDateColumn] as String;
    user = User.fromJson(jsonDecode(json[resourceUserColumn] as String));
  }

  Map<String, Object?> toJson() => {
        resourceIdColumn: resourceId,
        userIdColumn: userId,
        resourceTitleColumn: resourceTitle,
        resourceDescriptionColumn: resourceDescription,
        resourceUrlColumn: resourceUrl,
        resourceUploadDateColumn: resourceUploadDate,
        resourceUserColumn: user.toJson(),
      };
}
