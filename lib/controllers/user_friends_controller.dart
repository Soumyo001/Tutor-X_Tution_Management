import 'package:get/get.dart';
import 'package:tutor_x_tution_management/models/request.dart';

class UserFriendsController extends GetxController {
  final RxList<Request> _friends = <Request>[].obs;

  List<Request> get friends => _friends;

  set friends(List<Request> friends) {
    _friends.value = friends;
  }
}
