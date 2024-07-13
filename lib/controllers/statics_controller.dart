import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:tutor_x_tution_management/data/enums.dart';

class UserStaticsController extends GetxController {
  final RxString _userName = "".obs;
  final Rx<Uint8List?> _imageData = Rx<Uint8List?>(null);
  final _userCategory = UserCategory.student.obs;

  String get userName => _userName.value;
  Uint8List? get imageData => _imageData.value;
  UserCategory get userCategory => _userCategory.value;

  set userName(String userName) {
    _userName.value = userName;
  }

  set imageData(Uint8List? imageData) {
    _imageData.value = imageData;
  }

  set userCategory(UserCategory userCategory) {
    _userCategory.value = userCategory;
  }
}
