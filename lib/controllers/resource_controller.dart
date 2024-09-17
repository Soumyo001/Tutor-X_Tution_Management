import 'package:get/get.dart';
import 'package:tutor_x_tution_management/models/resource.dart';

class ResourceController extends GetxController {
  final RxList<Resource> _resources = <Resource>[].obs;
  List<Resource> get resources => _resources;
  set resources(List<Resource> resources) {
    _resources.value = resources;
  }
}
