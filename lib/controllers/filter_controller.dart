import 'package:get/get.dart';
import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/models/student_post.dart';
import 'package:tutor_x_tution_management/models/tutor_post.dart';

class FilterController extends GetxController {
  final Rx<String?> _selectedValueArea = Rx<String?>(null);
  final Rx<StudentMedium?> _studentMedium = Rx<StudentMedium?>(null);
  final Rx<StudentTypes?> _studentTypes = Rx<StudentTypes?>(null);
  final Rx<SubjectTypes?> _subjectTypes = Rx<SubjectTypes?>(null);
  final RxList<StudentPost> _studentPosts = <StudentPost>[].obs;
  final RxList<TutorPost> _tutorPosts = <TutorPost>[].obs;

  String? get selectedValueArea => _selectedValueArea.value;
  StudentMedium? get studentMedium => _studentMedium.value;
  StudentTypes? get studentTypes => _studentTypes.value;
  SubjectTypes? get subjectTypes => _subjectTypes.value;
  List<StudentPost> get studentPosts => _studentPosts;
  List<TutorPost> get tutorPosts => _tutorPosts;

  set studentPosts(List<StudentPost> studentPosts) {
    _studentPosts.value = studentPosts;
  }

  set tutorPosts(List<TutorPost> tutorPosts) {
    _tutorPosts.value = tutorPosts;
  }

  set selectedValueArea(String? selectedValueArea) {
    _selectedValueArea.value = selectedValueArea;
  }

  set setStudentMedium(String? studentMedium) {
    if (studentMedium == null) {
      _studentMedium.value = null;
    } else {
      _studentMedium.value = StudentMedium.values.firstWhere((element) =>
          element.toString().split('.').last.replaceAll('_', ' ') ==
          studentMedium);
    }
  }

  set setStudentTypes(String? studentTypes) {
    if (studentTypes == null) {
      _studentTypes.value = null;
    } else {
      _studentTypes.value = StudentTypes.values.firstWhere((element) =>
          element
              .toString()
              .split('.')
              .last
              .replaceAll('_', ' ')
              .replaceAll('to', '-') ==
          studentTypes);
    }
  }

  set setSubjectTypes(String? subjectTypes) {
    if (subjectTypes == null) {
      _subjectTypes.value = null;
    } else {
      _subjectTypes.value = SubjectTypes.values.firstWhere((element) =>
          element.toString().split('.').last.replaceAll('_', ' ') ==
          subjectTypes);
    }
  }
}
