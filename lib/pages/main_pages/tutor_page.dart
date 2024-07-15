import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tutor_x_tution_management/components/filtering.dart';
import 'package:tutor_x_tution_management/components/recent_tutor_post_display.dart';
import 'package:tutor_x_tution_management/controllers/filter_controller.dart';
import 'package:tutor_x_tution_management/pages/navigation_bar/navigation_panel.dart';
import 'package:tutor_x_tution_management/service/api/tutor_post_api.dart';
import 'dart:developer' as dev;

class TutorPage extends StatefulWidget {
  const TutorPage({super.key});

  @override
  State<TutorPage> createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
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
      body: Column(
        children: [
          const NavigationPanel(),
          const Gap(18),
          Filtering(
            onFilter: () async {
              final tutorPost = await TutorPostApi().getTutorPostsByFilter(
                _filterController.selectedValueArea,
                _filterController.studentMedium?.index,
                _filterController.subjectTypes?.index,
                _filterController.studentTypes?.index,
              );
              _filterController.tutorPosts = tutorPost;
              dev.log(
                  'area: ${_filterController.selectedValueArea} student medium: ${_filterController.studentMedium} subject type: ${_filterController.subjectTypes} student type: ${_filterController.studentTypes}');
            },
            text: 'Find your Tutors',
          ),
          const Gap(10),
          Expanded(
            child: ScrollTransformView(
              children: [
                ScrollTransformItem(
                  builder: (scrollOffset) => const RecentTutorPost(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
