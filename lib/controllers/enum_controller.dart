import 'package:flutter/Material.dart';
import 'package:tutor_x_tution_management/data/enums.dart';

class EnumController with ChangeNotifier {
  AvailabilityStatus _availabilityStatus = AvailabilityStatus.available;
  PaymentMethod _paymentMethod = PaymentMethod.bkash;
  PaymentStatus _paymentStatus = PaymentStatus.notPaid;
  ProfessionType _professionType = ProfessionType.student;
  RequestStatus _requestStatus = RequestStatus.decline;
  SessionStatus _sessionStatus = SessionStatus.closed;
  StudentMedium _studentMedium = StudentMedium.bangla;
  StudentTypes _studentTypes = StudentTypes.class_1_to_class_5;
  SubjectTypes _subjectTypes = SubjectTypes.bangla;
  TutorBackgroundCheckType _tutorBackgroundCheckType =
      TutorBackgroundCheckType.educational;
  UserCategory _userCategory = UserCategory.student;
  VerificationStatus _verificationStatus = VerificationStatus.unverified;

  //getters
  AvailabilityStatus get availabilityStatus => _availabilityStatus;
  PaymentMethod get paymentMethod => _paymentMethod;
  PaymentStatus get paymentStatus => _paymentStatus;
  ProfessionType get professionType => _professionType;
  RequestStatus get requestStatus => _requestStatus;
  SessionStatus get sessionStatus => _sessionStatus;
  StudentMedium get studentMedium => _studentMedium;
  StudentTypes get studentTypes => _studentTypes;
  SubjectTypes get subjectTypes => _subjectTypes;
  TutorBackgroundCheckType get tutorBackgroundCheckType =>
      _tutorBackgroundCheckType;
  UserCategory get userCategory => _userCategory;
  VerificationStatus get verificationStatus => _verificationStatus;

  //setters
  set availabilityStatus(AvailabilityStatus status) {
    _availabilityStatus = status;
    notifyListeners();
  }

  set paymentMethod(PaymentMethod method) {
    _paymentMethod = method;
    notifyListeners();
  }

  set paymentStatus(PaymentStatus status) {
    _paymentStatus = status;
    notifyListeners();
  }

  set professionType(ProfessionType type) {
    _professionType = type;
    notifyListeners();
  }

  set requestStatus(RequestStatus status) {
    _requestStatus = status;
    notifyListeners();
  }

  set sessionStatus(SessionStatus status) {
    _sessionStatus = status;
    notifyListeners();
  }

  set studentMedium(StudentMedium medium) {
    _studentMedium = medium;
    notifyListeners();
  }

  set studentTypes(StudentTypes types) {
    _studentTypes = types;
    notifyListeners();
  }

  set subjectTypes(SubjectTypes types) {
    _subjectTypes = types;
    notifyListeners();
  }

  set tutorBackgroundCheckType(TutorBackgroundCheckType type) {
    _tutorBackgroundCheckType = type;
    notifyListeners();
  }

  set userCategory(UserCategory category) {
    _userCategory = category;
    notifyListeners();
  }

  set verificationStatus(VerificationStatus status) {
    _verificationStatus = status;
    notifyListeners();
  }
}
