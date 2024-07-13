import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tutor_x_tution_management/components/recent_student_post_display.dart';
import 'package:tutor_x_tution_management/components/students_filtering.dart';
import 'package:tutor_x_tution_management/controllers/filter_controller.dart';
import 'package:tutor_x_tution_management/pages/navigation_bar/navigation_panel.dart';
import 'package:tutor_x_tution_management/service/api/student_post_api.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  late final FilterController _filterController;

  @override
  void initState() {
    super.initState();
    _filterController = Get.find<FilterController>();
    _filterController.selectedValueArea = null;
    _filterController.setStudentMedium = null;
    _filterController.setStudentTypes = null;
    _filterController.setSubjectTypes = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Column(
          children: [
            const NavigationPanel(),
            const Gap(18),
            StudentFiltering(
              onFilter: () async {
                final studentPosts =
                    await StudentPostApi().getStudentPostsByFilter(
                  _filterController.selectedValueArea,
                  _filterController.studentMedium?.index,
                  _filterController.studentTypes?.index,
                  _filterController.subjectTypes?.index,
                );
                _filterController.studentPosts = studentPosts;
              },
            ),
            const Gap(10),
            Expanded(
              child: ScrollTransformView(children: [
                ScrollTransformItem(
                  builder: (scrollOffset) => const RecentStudentPosts(),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
