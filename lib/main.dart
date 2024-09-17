import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tutor_x_tution_management/controllers/enum_controller.dart';
import 'package:tutor_x_tution_management/controllers/filter_controller.dart';
import 'package:tutor_x_tution_management/controllers/nav_option_index_controller.dart';
import 'package:tutor_x_tution_management/controllers/report_controller.dart';
import 'package:tutor_x_tution_management/controllers/request_controller.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'package:tutor_x_tution_management/controllers/user_friends_controller.dart';
import 'package:tutor_x_tution_management/controllers/user_post_controller.dart';
import 'package:tutor_x_tution_management/pages/auth.dart';
import 'package:tutor_x_tution_management/routes/route.dart';
import 'package:tutor_x_tution_management/service/auth/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.fromFirebase().initializeApp();
  Get.put(UserStaticsController());
  Get.put(FilterController());
  Get.put(NavIndexController());
  Get.put(RequestController());
  Get.put(UserFriendsController());
  Get.put(UserPostController());
  Get.put(ReportController());
  runApp(
    ChangeNotifierProvider(
      create: (context) => EnumController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tutor-X: Tution ManageMent',
      home: const Auth(),
      initialRoute: AuthService.fromFirebase().isLoggedIn()
          ? WebRoutes.gatePage
          : WebRoutes.authPage,
      getPages: WebRoutes.routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
    );
  }
}
