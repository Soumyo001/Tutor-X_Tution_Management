import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/components/filtering.dart';
import 'package:tutor_x_tution_management/components/recent_student_post_display.dart';
import 'package:tutor_x_tution_management/controllers/filter_controller.dart';
import 'package:tutor_x_tution_management/pages/navigation_bar/navigation_panel.dart';
import 'package:tutor_x_tution_management/service/api/student_post_api.dart';

class TutionsPage extends StatefulWidget {
  const TutionsPage({super.key});

  @override
  State<TutionsPage> createState() => _TutionsPageState();
}

class _TutionsPageState extends State<TutionsPage> {
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
            text: 'Find Your Students',
            onFilter: () async {
              final studentPosts =
                  await StudentPostApi().getStudentPostsByFilter(
                null,
                _filterController.selectedValueArea,
                _filterController.studentMedium?.index,
                _filterController.studentTypes?.index,
                _filterController.subjectTypes?.index,
              );
              _filterController.studentPosts = studentPosts;
            },
          ),
          const Gap(10),
          const Expanded(
            child: RecentStudentPosts(hasLimit: false),
          ),
        ],
      ),
    );
  }
}
