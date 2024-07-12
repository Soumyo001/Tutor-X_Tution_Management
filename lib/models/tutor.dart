import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

class Tutor {
  late int tutorId;
  late int userId;
  late AvailabilityStatus status;
  late StudentMedium mediumOfInterest;
  late StudentTypes expectedStudent;
  late SubjectTypes subjectOfInterest;
  late int expectedSalary;
  late ProfessionType profession;
  late VerificationStatus verificationStatus;
  late String tutorSelfDescription;
  late String? imageData;

  Tutor({
    required this.tutorId,
    required this.userId,
    required this.status,
    required this.mediumOfInterest,
    required this.expectedStudent,
    required this.subjectOfInterest,
    required this.expectedSalary,
    required this.profession,
    required this.verificationStatus,
    required this.tutorSelfDescription,
    required this.imageData,
  });

  Tutor.fromJson(Map<String, Object?> json) {
    tutorId = json[tutorIdColumn] as int;
    userId = json[userIdColumn] as int;
    status =
        AvailabilityStatus.values[json[tutorAvailabilityStatusColumn] as int];
    mediumOfInterest =
        StudentMedium.values[json[tutorMediumOfInterestColumn] as int];
    expectedStudent =
        StudentTypes.values[json[tutorExpectedStudentColumn] as int];
    subjectOfInterest =
        SubjectTypes.values[json[tutorSubjectOfInterestColumn] as int];
    expectedSalary = json[tutorExpectedSalaryColumn] as int;
    profession = ProfessionType.values[json[tutorProfessionColumn] as int];
    verificationStatus =
        VerificationStatus.values[json[tutorVerificationColumn] as int];
    tutorSelfDescription = json[tutorSelfDescriptionColumn] as String;
    imageData = json[tutorImagePathColumn] as String?;
  }

  Map<String, Object?> toJson() => {
        tutorIdColumn: tutorId,
        userIdColumn: userId,
        tutorAvailabilityStatusColumn: status.index,
        tutorMediumOfInterestColumn: mediumOfInterest.index,
        tutorExpectedStudentColumn: expectedStudent.index,
        tutorSubjectOfInterestColumn: subjectOfInterest.index,
        tutorExpectedSalaryColumn: expectedSalary,
        tutorProfessionColumn: profession.index,
        tutorVerificationColumn: verificationStatus.index,
        tutorSelfDescriptionColumn: tutorSelfDescription,
        tutorImagePathColumn: imageData,
      };

  @override
  bool operator ==(covariant Tutor other) => tutorId == other.tutorId;

  @override
  String toString() =>
      'tutor_id = $tutorId, user_id = $userId, status = $status, medium of interest = $mediumOfInterest, expected student = $expectedStudent, expected salary= $expectedSalary, subject of interest = $subjectOfInterest, profession = $profession, verification status = $verificationStatus, self description = $tutorSelfDescription';

  @override
  int get hashCode => tutorId.hashCode;
}
