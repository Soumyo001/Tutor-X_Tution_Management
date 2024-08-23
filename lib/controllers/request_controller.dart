import 'package:get/get.dart';
import 'package:tutor_x_tution_management/models/request.dart';

class RequestController extends GetxController {
  final RxList<Request> _requests = <Request>[].obs;

  List<Request> get requests => _requests;

  set requests(List<Request> requests) {
    _requests.value = requests;
  }
}
