import 'package:get/get.dart';
import 'package:tutor_x_tution_management/models/student_post.dart';
import 'package:tutor_x_tution_management/models/tutor_post.dart';

class UserPostController extends GetxController {
  final RxList<StudentPost> _studentPosts = <StudentPost>[].obs;
  final RxList<TutorPost> _tutorPosts = <TutorPost>[].obs;

  List<TutorPost> get tutorPosts => _tutorPosts;
  List<StudentPost> get studentPosts => _studentPosts;

  set tutorPosts(List<TutorPost> tutorPosts) {
    _tutorPosts.value = tutorPosts;
  }

  set studentPosts(List<StudentPost> studentPosts) {
    _studentPosts.value = studentPosts;
  }
}
/*  final RxList<StudentPost> _studentPosts = <StudentPost>[].obs;
  final RxList<TutorPost> _tutorPosts = <TutorPost>[].obs;

  List<StudentPost> get studentPosts => _studentPosts;
  List<TutorPost> get tutorPosts => _tutorPosts;

  set studentPosts(List<StudentPost> studentposts) {
    _studentPosts.value = studentPosts;
  }

  set tutorPosts(List<TutorPost> tutorPosts) {
    _tutorPosts.value = tutorPosts;
  } */