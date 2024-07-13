import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:tutor_x_tution_management/data/enums.dart';

class UserStaticsController extends GetxController {
  final RxString _userName = "".obs;
  final RxString _userEmail = "".obs;
  final RxString _userLocation = "".obs;
  final RxString _userEducation = "".obs;
  final RxString _userPhoneNumber = "".obs;
  final Rx<Uint8List?> _imageData = Rx<Uint8List?>(null);
  final _userCategory = UserCategory.student.obs;

  String get userName => _userName.value;
  String get userEmail => _userEmail.value;
  String get userEducation => _userEducation.value;
  String get userLocation => _userLocation.value;
  String get userPhoneNumber => _userPhoneNumber.value;
  Uint8List? get imageData => _imageData.value;
  UserCategory get userCategory => _userCategory.value;

  set userName(String userName) {
    _userName.value = userName;
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
}
