import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

class Student {
  late int studentId;
  late int userId;
  late String firstName;
  late String lastName;
  late StudentMedium studentMedium;
  late String studentSelfDescription;
  late String? imageData;

  Student({
    required this.studentId,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.studentMedium,
    required this.studentSelfDescription,
    required this.imageData,
  });

  Student.fromJson(Map<String, Object?> json) {
    studentId = json[studentIdColumn] as int;
    userId = json[userIdColumn] as int;
    firstName = json[studentFirstNameColumn] as String;
    lastName = json[studentLastNameColumn] as String;
    studentMedium = StudentMedium.values[json[studentMediumColumn] as int];
    studentSelfDescription = json[studentSelfDescriptionColumn] as String;
    imageData = json[studentImagePathColumn] as String?;
  }

  Map<String, Object?> toJson() => {
        studentIdColumn: studentId,
        userIdColumn: userId,
        studentFirstNameColumn: firstName,
        studentLastNameColumn: lastName,
        studentMediumColumn: studentMedium.index,
        studentSelfDescriptionColumn: studentSelfDescription,
        studentImagePathColumn: imageData,
      };

  @override
  bool operator ==(covariant Student other) => studentId == other.studentId;

  @override
  String toString() =>
      'student_id = $studentId, user_id = $userId, first name = $firstName, last name = $lastName, student medium = $studentMedium, self desc= $studentSelfDescription, image path = $imageData';

  @override
  int get hashCode => studentId.hashCode;
}
