import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavIndexController extends GetxController {
  final RxInt _webNavIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadNavigationIndex();
  }

  int get webNavIndex => _webNavIndex.value;

  Future<void> loadNavigationIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _webNavIndex.value = prefs.getInt('navIndex') ?? 0;
  }

  Future<void> saveNavigationIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _webNavIndex.value = index;
    await prefs.setInt('navIndex', index);
  }
}
