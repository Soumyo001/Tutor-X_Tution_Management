import 'dart:async';
import 'dart:math';

import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/data/tips.dart';
import 'package:tutor_x_tution_management/utils/dialogs/error_dialog.dart';

class Advertisement extends StatefulWidget {
  const Advertisement({super.key});

  @override
  State<Advertisement> createState() => _AdvertisementState();
}

class _AdvertisementState extends State<Advertisement> {
  RxString currentTip = Tips.tipsStudent[0].obs;

  void _changeTips() async {
    int prevIdx = 0;
    try {
      Timer.periodic(const Duration(seconds: 30), (timer) {
        final r = Random();
        int idx = r.nextInt(100) % Tips.tipsStudent.length;
        while (idx == prevIdx) {
          idx = r.nextInt(100) % Tips.tipsStudent.length;
        }
        prevIdx = idx;
        currentTip.value = Tips.tipsStudent[idx];
      });
    } catch (e) {
      await showErrorDialog(context, e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _changeTips();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(50),
              border: const Border(
                left: BorderSide(color: Colors.grey),
                right: BorderSide(color: Colors.grey),
                top: BorderSide(color: Colors.grey),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'did you know ?'.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Text(
                    currentTip.value,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: 14,
                    ),
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
