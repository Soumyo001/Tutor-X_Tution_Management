import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:tutor_x_tution_management/pages/auth.dart';
import 'package:tutor_x_tution_management/pages/main_pages/about_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/home_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/pre_info_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/resource_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/students_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/tutions_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/tutor_page.dart';

class WebRoutes {
  static int webNavigationBarIndex = 0;
  static const homePage = '/';
  static const gatePage = '/gate';
  static const tutorsPage = '/tutor';
  static const tutionsPage = '/tutions';
  static const studentPage = '/students';
  static const resourcePage = '/resources';
  static const aboutPage = '/about';
  static const authPage = '/OAuthenticatior';
  static final List<GetPage> routes = [
    GetPage(
      name: authPage,
      page: () => const Auth(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: gatePage,
      page: () => const PreInfoPage(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: homePage,
      page: () => const HomePage(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: tutorsPage,
      page: () => const TutorPage(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: tutionsPage,
      page: () => const TutionsPage(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: studentPage,
      page: () => const StudentPage(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: resourcePage,
      page: () => const ResourcePage(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: aboutPage,
      page: () => const AboutPage(),
      transition: Transition.leftToRightWithFade,
    ),
  ];
}
