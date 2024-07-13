// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/components/nav_tile.dart';
import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/data/nav_entry.dart';
import 'package:tutor_x_tution_management/models/menu_model.dart';
import 'package:tutor_x_tution_management/routes/route.dart';
import 'package:tutor_x_tution_management/service/auth/auth_service.dart';
import 'package:tutor_x_tution_management/utils/dialogs/logout_dialog.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';

typedef ItemTap = void Function()?;

class NavBuildEntry extends StatefulWidget {
  const NavBuildEntry({super.key});

  @override
  State<NavBuildEntry> createState() => _NavBuildEntryState();
}

class _NavBuildEntryState extends State<NavBuildEntry> {
  late final UserStaticsController _userStaticsController;

  @override
  void initState() {
    super.initState();
    _userStaticsController = Get.find<UserStaticsController>();
  }

  @override
  Widget build(BuildContext context) {
    final menuData = NavEntry();
    return Obx(
      () => (_userStaticsController.userCategory == UserCategory.teacher
          ? ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: menuData.navEntriesForTutor.length,
              itemBuilder: (context, index) => navMenuEntry(
                  index, menuData.navEntriesForTutor[index], context),
            )
          : ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: menuData.navEntriesForStudent.length,
              itemBuilder: (context, index) => navMenuEntry(
                  index, menuData.navEntriesForStudent[index], context),
            )),
    );
  }

  Widget navMenuEntry(int index, MenuModel menuModel, BuildContext context) {
    final bool isSelected = WebRoutes.webNavigationBarIndex == index;
    return NavigationTile(
      text: menuModel.text,
      onTap: () async {
        switch (index) {
          case 0:
            Get.offNamed(WebRoutes.homePage);
            break;
          case 1:
            _userStaticsController.userCategory == UserCategory.teacher
                ? Get.offNamed(WebRoutes.studentPage)
                : Get.offNamed(WebRoutes.tutorsPage);
            break;
          case 2:
            Get.offNamed(WebRoutes.tutionsPage);
            break;
          case 3:
            Get.offNamed(WebRoutes.resourcePage);
            break;
          case 4:
            Get.offNamed(WebRoutes.aboutPage);
            break;
          case 5:
            final shouldLogout =
                await showLogoutDialog(context, 'Do you want to logout ?');
            if (shouldLogout) {
              await AuthService.fromFirebase().logOut();
              Get.offAllNamed(
                WebRoutes.authPage,
                predicate: (route) => false,
              );
            }
            break;
          default:
            break;
        }
        setState(() {
          WebRoutes.webNavigationBarIndex = index;
        });
      },
      isSelected: isSelected,
    );
  }
}
