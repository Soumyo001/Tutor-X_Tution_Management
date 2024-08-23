import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/components/advertisement_widget.dart';
import 'package:tutor_x_tution_management/components/recent_post_text.dart';
import 'package:tutor_x_tution_management/components/recent_student_post_display.dart';
import 'package:tutor_x_tution_management/components/recent_tutor_post_display.dart';
import 'package:tutor_x_tution_management/controllers/nav_option_index_controller.dart';
import 'package:tutor_x_tution_management/routes/route.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late final NavIndexController _navIndexController;

  @override
  void initState() {
    super.initState();
    _navIndexController = Get.find<NavIndexController>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RecentPost(
            text: 'Tutors (Recently Posted)',
            buttonText: 'View All',
            onPressed: () async {
              await _navIndexController.saveNavigationIndex(1);
              Get.offNamed(WebRoutes.tutorsPage);
            },
          ),
          const Gap(10),
          const RecentTutorPost(hasLimit: true),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64.0),
            child: Divider(
              thickness: 1,
              height: 1,
              color: Colors.grey.withAlpha(150),
            ),
          ),
          const Gap(20),
          const Advertisement(),
          const Gap(20),
          RecentPost(
            onPressed: () async {
              await _navIndexController.saveNavigationIndex(2);
              Get.offNamed(WebRoutes.tutionsPage);
            },
            text: 'Students (Recently Posted)',
            buttonText: 'View All',
          ),
          const Gap(20),
          const RecentStudentPosts(hasLimit: true),
        ],
      ),
    );
  }
}
