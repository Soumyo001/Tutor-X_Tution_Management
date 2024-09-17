import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/color_pallete.dart';
import 'package:tutor_x_tution_management/components/tutor_display_widget.dart';
import 'package:tutor_x_tution_management/controllers/filter_controller.dart';
import 'package:tutor_x_tution_management/models/student_post.dart';
import 'package:tutor_x_tution_management/routes/route.dart';
import 'package:tutor_x_tution_management/service/api/student_post_api.dart';

class RecentStudentPosts extends StatefulWidget {
  final bool hasLimit;
  const RecentStudentPosts({super.key, required this.hasLimit});

  @override
  State<RecentStudentPosts> createState() => _RecentStudentPostsState();
}

class _RecentStudentPostsState extends State<RecentStudentPosts> {
  late final FilterController _filterController;

  @override
  void initState() {
    super.initState();
    _filterController = Get.find<FilterController>();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: 0.45 * screenSize.height,
      width: screenSize.width * 0.55,
      child: FutureBuilder(
        future: StudentPostApi()
            .getStudentPostsByFilter(null, null, null, null, null),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _filterController.studentPosts =
                  snapshot.data as List<StudentPost>;
            });
            return Obx(
              () => _filterController.studentPosts.isEmpty
                  ? Center(
                      child: Text(
                        'It\'s quiet right now...'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 3,
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: screenSize.width < 800 ? 2 : 3),
                      itemCount: widget.hasLimit
                          ? _filterController.studentPosts.length >= 3
                              ? 3
                              : _filterController.studentPosts.length
                          : _filterController.studentPosts.length,
                      itemBuilder: (context, index) {
                        final studentPost = _filterController.studentPosts[
                            widget.hasLimit
                                ? _filterController.studentPosts.length >= 3
                                    ? (index +
                                        (_filterController.studentPosts.length -
                                            3))
                                    : index
                                : index];
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey.withAlpha(150)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withAlpha(50),
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey.withAlpha(150),
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TutorDisplayWidget(
                                        text: studentPost.subjectTypes
                                            .toString()
                                            .split('.')
                                            .last
                                            .replaceAll('_', ' '),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontColor: Colors.black87,
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(13),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: TutorDisplayWidget(
                                          text: 'Name: ${studentPost.fullName}',
                                          fontSize: 15,
                                          fontColor: Colors.grey.shade600,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: TutorDisplayWidget(
                                          text:
                                              'Education: ${studentPost.education}',
                                          fontSize: 15,
                                          fontColor: Colors.grey.shade600,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: TutorDisplayWidget(
                                          text:
                                              'Location: ${studentPost.location}',
                                          fontSize: 15,
                                          fontColor: Colors.grey.shade600,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: TutorDisplayWidget(
                                          text:
                                              'Day: ${studentPost.days.toString().split('.').last.replaceAll('_', ' ')}',
                                          fontSize: 15,
                                          fontColor: Colors.grey.shade600,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: TutorDisplayWidget(
                                          text: 'salary: ${studentPost.salary}',
                                          fontSize: 15,
                                          fontColor: Colors.grey.shade600,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withAlpha(50),
                                    border: Border(
                                      top: BorderSide(
                                          color: Colors.grey.withAlpha(150)),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      MaterialButton(
                                        onPressed: () {
                                          Get.toNamed(
                                            WebRoutes.postView,
                                            arguments: {
                                              "student_post": studentPost
                                            },
                                          );
                                        },
                                        padding: const EdgeInsets.all(16),
                                        color: Pallete.buttonColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            3,
                                          ),
                                        ),
                                        child: const Text(
                                          'Learn More',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
