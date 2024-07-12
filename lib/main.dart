import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:tutor_x_tution_management/controllers/enum_controller.dart';
import 'package:tutor_x_tution_management/pages/main_pages/home_page.dart';
import 'package:tutor_x_tution_management/routes/route.dart';
import 'package:tutor_x_tution_management/service/auth/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.fromFirebase().initializeApp();
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
      home: const HomePage(),
      initialRoute: AuthService.fromFirebase().isLoggedIn()
          ? WebRoutes.homePage
          : WebRoutes.authPage,
      getPages: WebRoutes.routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
    );
  }
}
