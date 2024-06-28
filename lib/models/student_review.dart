import 'dart:convert';

import 'package:tutor_x_tution_management/models/student.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

class StudentReview {
  late int studentReviewId;
  late int studentId;
  late int tutorId;
  late int rating;
  late String reviewText;
  late String reviewDate;
  late Student student;

  StudentReview({
    required this.studentReviewId,
    required this.studentId,
    required this.tutorId,
    required this.rating,
    required this.reviewText,
    required this.reviewDate,
    required this.student,
  });

  StudentReview.fromJson(Map<String, Object?> json) {
    studentReviewId = json[studentReviewIdColumn] as int;
    studentId = json[studentIdColumn] as int;
    tutorId = json[tutorIdColumn] as int;
    rating = json[studentReviewRatingColumn] as int;
    reviewText = json[studentReviewTextColumn] as String;
    reviewDate = json[studentReviewDateColumn] as String;
    student = Student.fromJson(
        jsonDecode(json[studentReviewStudentColumn] as String));
  }

  Map<String, Object?> toJson() => {
        studentReviewIdColumn: studentReviewId,
        studentIdColumn: studentId,
        tutorIdColumn: tutorId,
        studentReviewRatingColumn: rating,
        studentReviewTextColumn: reviewText,
        studentReviewDateColumn: reviewDate,
        studentReviewStudentColumn: student.toJson(),
      };
}
