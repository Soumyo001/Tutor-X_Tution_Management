import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/models/student.dart';
import 'package:tutor_x_tution_management/models/tutor.dart';

class UserStaticsController extends GetxController {
  final RxString _userName = "".obs;
  final RxInt _userId = 0.obs;
  final RxString _userEmail = "".obs;
  final RxString _userLocation = "".obs;
  final RxString _userEducation = "".obs;
  final RxString _userPhoneNumber = "".obs;
  final RxString _tutorSelfDesc = "".obs;
  final RxInt _tutorSalary = 0.obs;
  final RxInt _userReports = 0.obs;
  final Rx<Uint8List?> _imageData = Rx<Uint8List?>(null);
  final _userCategory = UserCategory.student.obs;
  final _tutorProfessionType = ProfessionType.student.obs;
  final _tutorVerificationStatus = VerificationStatus.unverified.obs;
  final _tutorAvailabilityStatus = AvailabilityStatus.notAvailabe.obs;
  final _tutorSubjectType = SubjectTypes.bangla.obs;
  final _tutorStudentMedium = StudentMedium.bangla.obs;
  final _tutorStudentType = StudentTypes.kinder_garden.obs;
  final _studentMedium = StudentMedium.bangla.obs;
  final RxString _studentSelfDesc = "".obs;

  final Rx<Tutor?> _tutor = Rx<Tutor?>(null);
  final Rx<Student?> _student = Rx<Student?>(null);

  int get userId => _userId.value;
  int get userReports => _userReports.value;
  String get userName => _userName.value;
  String get userEmail => _userEmail.value;
  String get userEducation => _userEducation.value;
  String get userLocation => _userLocation.value;
  String get userPhoneNumber => _userPhoneNumber.value;
  String get tutorSelfDesc => _tutorSelfDesc.value;
  String get studentSelfDesc => _studentSelfDesc.value;
  int get tutorSalary => _tutorSalary.value;
  Uint8List? get imageData => _imageData.value;
  UserCategory get userCategory => _userCategory.value;
  Tutor? get tutor => _tutor.value;
  Student? get student => _student.value;
  ProfessionType get tutorProfessionType => _tutorProfessionType.value;
  VerificationStatus get tutorVerificationStatus =>
      _tutorVerificationStatus.value;
  AvailabilityStatus get tutorAvailabilityStatus =>
      _tutorAvailabilityStatus.value;
  SubjectTypes get tutorSubjectType => _tutorSubjectType.value;
  StudentMedium get tutorStudentMedium => _tutorStudentMedium.value;
  StudentMedium get studentMedium => _studentMedium.value;
  StudentTypes get tutorStudentType => _tutorStudentType.value;

  set userName(String userName) {
    _userName.value = userName;
  }

  set userReports(int userReports) {
    _userReports.value = userReports;
  }

  set studentSelfDesc(String studentSelfDesc) {
    _studentSelfDesc.value = studentSelfDesc;
  }

  set studentMedium(StudentMedium studentMedium) {
    _studentMedium.value = studentMedium;
  }

  set userId(int userId) {
    _userId.value = userId;
  }

  set userEducation(String userEducation) {
    _userEducation.value = userEducation;
  }

  set userLocation(String userLocation) {
    _userLocation.value = userLocation;
  }

  set userPhoneNumber(String userPhoneNumber) {
    _userPhoneNumber.value = userPhoneNumber;
  }

  set userEmail(String userEmail) {
    _userEmail.value = userEmail;
  }

  set imageData(Uint8List? imageData) {
    _imageData.value = imageData;
  }

  set userCategory(UserCategory userCategory) {
    _userCategory.value = userCategory;
  }

  set tutorSelfDesc(String value) {
    _tutorSelfDesc.value = value;
  }

  set tutorSalary(int value) {
    _tutorSalary.value = value;
  }

  set tutor(Tutor? tutor) {
    _tutor.value = tutor;
  }

  set student(Student? student) {
    _student.value = student;
  }

  set tutorProfessionType(ProfessionType value) {
    _tutorProfessionType.value = value;
  }

  set tutorVerificationStatus(VerificationStatus value) {
    _tutorVerificationStatus.value = value;
  }

  set tutorAvailabilityStatus(AvailabilityStatus value) {
    _tutorAvailabilityStatus.value = value;
  }

  set tutorSubjectType(SubjectTypes value) {
    _tutorSubjectType.value = value;
  }

  set tutorStudentMedium(StudentMedium value) {
    _tutorStudentMedium.value = value;
  }

  set tutorStudentType(StudentTypes value) {
    _tutorStudentType.value = value;
  }
}
