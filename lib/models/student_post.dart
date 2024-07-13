// To parse this JSON data, do
//
//     final studentPost = studentPostFromJson(jsonString);

import 'dart:convert';

import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

StudentPost studentPostFromJson(String str) =>
    StudentPost.fromJson(json.decode(str));

String studentPostToJson(StudentPost data) => json.encode(data.toJson());

class StudentPost {
  int studentPostId;
  int studentId;
  String fullName;
  TutionDays days;
  String location;
  String education;
  StudentMedium studentMedium;
  StudentTypes studentTypes;
  SubjectTypes subjectTypes;
  int salary;

  StudentPost({
    required this.studentPostId,
    required this.studentId,
    required this.fullName,
    required this.days,
    required this.location,
    required this.education,
    required this.studentMedium,
    required this.studentTypes,
    required this.subjectTypes,
    required this.salary,
  });

  factory StudentPost.fromJson(Map<String, Object?> json) => StudentPost(
        studentPostId: json[studentPostIdColumn] as int,
        studentId: json[studentIdColumn] as int,
        fullName: json[studentPostFullNameColumn] as String,
        days: TutionDays.values[json[studentPostTutionDaysColumn] as int],
        location: json[studentPostLocationColumn] as String,
        education: json[studentPostEducationColumn] as String,
        studentMedium:
            StudentMedium.values[json[studentPostStudentMediumColumn] as int],
        studentTypes:
            StudentTypes.values[json[studentPostStudentTypesColumn] as int],
        subjectTypes:
            SubjectTypes.values[json[studentPostSubjectTypesColumn] as int],
        salary: json[studentPostSalaryColumn] as int,
      );

  Map<String, Object?> toJson() => {
        studentPostIdColumn: studentPostId,
        studentIdColumn: studentId,
        studentPostFullNameColumn: fullName,
        studentPostTutionDaysColumn: days.index,
        studentPostLocationColumn: location,
        studentPostEducationColumn: education,
        studentPostStudentMediumColumn: studentMedium.index,
        studentPostStudentTypesColumn: studentTypes.index,
        studentPostSubjectTypesColumn: subjectTypes.index,
        studentPostSalaryColumn: salary,
      };
}
