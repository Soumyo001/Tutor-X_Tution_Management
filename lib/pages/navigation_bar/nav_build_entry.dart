// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/components/nav_tile.dart';
import 'package:tutor_x_tution_management/controllers/nav_option_index_controller.dart';

import 'package:tutor_x_tution_management/data/nav_entry.dart';
import 'package:tutor_x_tution_management/models/menu_model.dart';
import 'package:tutor_x_tution_management/routes/route.dart';
import 'package:tutor_x_tution_management/service/auth/auth_service.dart';
import 'package:tutor_x_tution_management/utils/dialogs/logout_dialog.dart';
import 'dart:developer' as dev;

typedef ItemTap = void Function()?;

class NavBuildEntry extends StatefulWidget {
  const NavBuildEntry({super.key});

  @override
  State<NavBuildEntry> createState() => _NavBuildEntryState();
}

class _NavBuildEntryState extends State<NavBuildEntry> {
  late final NavIndexController _navIndexController;

  @override
  void initState() {
    super.initState();
    _navIndexController = Get.find<NavIndexController>();
  }

  @override
  Widget build(BuildContext context) {
    final menuData = NavEntry();
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: menuData.navEntries.length,
      itemBuilder: (context, index) =>
          navMenuEntry(index, menuData.navEntries[index], context),
    );
  }

  Widget navMenuEntry(int index, MenuModel menuModel, BuildContext context) {
    return Obx(
      () {
        final bool isSelected = _navIndexController.webNavIndex == index;
        return NavigationTile(
          text: menuModel.text,
          onTap: () async {
            switch (index) {
              case 0:
                Get.offNamed(WebRoutes.gatePage);
                break;
              case 1:
                Get.offNamed(WebRoutes.tutorsPage);
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
            await _navIndexController.saveNavigationIndex(index);
            dev.log('${_navIndexController.webNavIndex.toString()}  $index');
          },
          isSelected: isSelected,
        );
      },
    );
  }
}
