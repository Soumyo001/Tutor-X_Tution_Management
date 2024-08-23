import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:tutor_x_tution_management/pages/auth.dart';
import 'package:tutor_x_tution_management/pages/main_pages/about_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/add_post_student.dart';
import 'package:tutor_x_tution_management/pages/main_pages/add_post_tutor.dart';
import 'package:tutor_x_tution_management/pages/main_pages/other_student_profile_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/others_tutor_profile_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/user_friends.dart';
import 'package:tutor_x_tution_management/pages/main_pages/user_posts.dart';
import 'package:tutor_x_tution_management/pages/views/post_views/post_view.dart';
import 'package:tutor_x_tution_management/pages/main_pages/pre_info_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/incoming_requests_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/student_profile_edit_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/student_profile_view_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/tutor_profile_edit_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/tutor_profile_view_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/resource_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/tutions_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/tutor_page.dart';

class WebRoutes {
  static const homePage = '/';
  static const gatePage = '/gate';
  static const tutorsPage = '/tutor';
  static const tutionsPage = '/tutions';
  static const resourcePage = '/resources';
  static const aboutPage = '/about';
  static const tutorProfilePage = '/profile/tutor';
  static const tutorProfileEditPage = '/profile/tutor/edit';
  static const studentProfilePage = '/profile/student';
  static const requestPage = '/requests';
  static const postView = '/postview';
  static const studentProfileEditPage = '/profile/student/edit';
  static const addPostTutor = '/profile/tutor/addpost';
  static const addPostStudent = '/profile/student/addpost';
  static const userFriendsPage = '/profile/friends';
  static const userPostPage = '/profile/posts';
  static const otherTutorProfilePage = '/tutor/profile';
  static const otherStudentProfilePage = '/student/profile';
  static const authPage = '/OAuthenticatior';
  static final List<GetPage> routes = [
    GetPage(
      name: authPage,
      page: () => const Auth(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: otherTutorProfilePage,
      page: () => const ProfilePageOtherTutor(),
      transition: Transition.native,
    ),
    GetPage(
      name: userFriendsPage,
      page: () => const UserFriends(),
      transition: Transition.native,
    ),
    GetPage(
      name: userPostPage,
      page: () => const UserPosts(),
      transition: Transition.native,
    ),
    GetPage(
      name: addPostTutor,
      page: () => const AddPostByTutor(),
      transition: Transition.native,
    ),
    GetPage(
      name: addPostStudent,
      page: () => const AddPostByStudent(),
      transition: Transition.native,
    ),
    GetPage(
      name: otherStudentProfilePage,
      page: () => const ProfilePageOtherStudent(),
      transition: Transition.native,
    ),
    GetPage(
      name: requestPage,
      page: () => const Requests(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: tutorProfilePage,
      page: () => const TutorProfileViewPage(),
      transition: Transition.native,
    ),
    GetPage(
      name: postView,
      page: () => const PostView(),
      transition: Transition.native,
    ),
    GetPage(
      name: tutorProfileEditPage,
      page: () => const TutorProfileViewEdit(),
    ),
    GetPage(
      name: studentProfilePage,
      page: () => const StudentProfilePage(),
      transition: Transition.native,
    ),
    GetPage(
      name: studentProfileEditPage,
      page: () => const StudentProfileEditPage(),
    ),
    GetPage(
      name: gatePage,
      page: () => const PreInfoPage(),
      transition: Transition.noTransition,
    ),
    // GetPage(
    //   name: homePage,
    //   page: () => const HomePage(),
    //   transition: Transition.noTransition,
    // ),
    GetPage(
      name: tutorsPage,
      page: () => const TutorPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: tutionsPage,
      page: () => const TutionsPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: resourcePage,
      page: () => const ResourcePage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: aboutPage,
      page: () => const AboutPage(),
      transition: Transition.noTransition,
    ),
  ];
}
