import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:tutor_x_tution_management/pages/auth.dart';
import 'package:tutor_x_tution_management/pages/main_pages/about_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/home_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/resource_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/students_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/tutions_page.dart';
import 'package:tutor_x_tution_management/pages/main_pages/tutor_page.dart';

class WebRoutes {
  static int webNavigationBarIndex = 0;
  static const homePage = '/';
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
    ),
    GetPage(
      name: homePage,
      page: () => const HomePage(),
    ),
    GetPage(
      name: tutorsPage,
      page: () => const TutorPage(),
    ),
    GetPage(
      name: tutionsPage,
      page: () => const TutionsPage(),
    ),
    GetPage(
      name: studentPage,
      page: () => const StudentPage(),
    ),
    GetPage(
      name: resourcePage,
      page: () => const ResourcePage(),
    ),
    GetPage(
      name: aboutPage,
      page: () => const AboutPage(),
    ),
  ];
}
