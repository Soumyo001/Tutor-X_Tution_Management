import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tutor_x_tution_management/controllers/report_controller.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'package:tutor_x_tution_management/pages/dashboard_home/dashboard_ui.dart';
import 'package:tutor_x_tution_management/pages/navigation_bar/navigation_panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final UserStaticsController _userStaticsController;
  late final ReportController _reportController;

  void _checkReports() {
    Timer(
      const Duration(seconds: 1),
      () async {
        if (!_reportController.hasReported &&
            _reportController.reportCount > 0 &&
            _reportController.reportCount <= 5) {
          print('I AM WORKINNGGGGGGGG');
          Get.snackbar(
            "You have been reported",
            "${5 - _reportController.reportCount} more reports and your account will be banned",
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 5),
          );
          _reportController.hasReported = true;
          await _reportController.saveReportCount(
            _reportController.reportCount,
            _reportController.hasReported,
            _userStaticsController.userId,
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _userStaticsController = Get.find<UserStaticsController>();
    _reportController = Get.find<ReportController>();
    _checkReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        children: [
          const NavigationPanel(),
          Expanded(
            child: ScrollTransformView(
              children: [
                ScrollTransformItem(
                  builder: (scrollOffset) => const DashBoard(),
                ),
                ScrollTransformItem(
                  builder: (scrollOffset) => Container(
                    height: 100,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
