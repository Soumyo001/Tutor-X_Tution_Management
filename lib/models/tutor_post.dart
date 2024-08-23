// To parse this JSON data, do
//
//     final tutorPost = tutorPostFromJson(jsonString);

import 'dart:convert';

import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

TutorPost tutorPostFromJson(String str) => TutorPost.fromJson(json.decode(str));

String tutorPostToJson(TutorPost data) => json.encode(data.toJson());

class TutorPost {
  int tutorPostId;
  int tutorId;
  String fullName;
  String bio;
  String location;
  String tutorDes;
  SubjectTypes subjectOfInterest;
  StudentMedium studentMedium;
  StudentTypes expectedStudent;

  TutorPost({
    required this.tutorPostId,
    required this.tutorId,
    required this.fullName,
    required this.bio,
    required this.location,
    required this.tutorDes,
    required this.subjectOfInterest,
    required this.studentMedium,
    required this.expectedStudent,
  });

  factory TutorPost.fromJson(Map<String, Object?> json) => TutorPost(
        tutorPostId: json[tutorPostIdColumn] as int,
        tutorId: json[tutorIdColumn] as int,
        fullName: json[tutorPostFullNameColumn] as String,
        bio: json[tutorPostBioColumn] as String,
        location: json[tutorPostLocationColumn] as String,
        tutorDes: json[tutorPostDescriptionColumn] as String,
        subjectOfInterest:
            SubjectTypes.values[json[tutorPostSubjectOfInterestColumn] as int],
        studentMedium:
            StudentMedium.values[json[tutorPostStudentMediumColumn] as int],
        expectedStudent:
            StudentTypes.values[json[tutorPostExpectedStudentColumn] as int],
      );

  Map<String, Object?> toJson() => {
        tutorPostIdColumn: tutorPostId,
        tutorIdColumn: tutorId,
        tutorPostFullNameColumn: fullName,
        tutorPostBioColumn: bio,
        tutorPostLocationColumn: location,
        tutorPostDescriptionColumn: tutorDes,
        tutorPostSubjectOfInterestColumn: subjectOfInterest.index,
        tutorPostStudentMediumColumn: studentMedium.index,
        tutorPostExpectedStudentColumn: expectedStudent.index,
      };
}
