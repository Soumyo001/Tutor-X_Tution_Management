import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportController extends GetxController {
  final RxBool _hasReported = false.obs;
  final RxInt _reportCount = 0.obs;

  bool get hasReported => _hasReported.value;
  int get reportCount => _reportCount.value;

  set hasReported(bool hasReported) {
    _hasReported.value = hasReported;
  }

  set reportCount(int reportCount) {
    _reportCount.value = reportCount;
  }

  Future<void> loadReportCount(int uid) async {
    final prefs = await SharedPreferences.getInstance();
    _hasReported.value = prefs.getBool('hasReported_$uid') ?? false;
    _reportCount.value = prefs.getInt('reportCount_$uid') ?? 0;
  }

  Future<void> saveReportCount(
      int reportCount, bool hasReported, int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasReported_$userId', hasReported);
    await prefs.setInt('reportCount_$userId', reportCount);
  }
}
