import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/components/nav_tile.dart';
import 'package:tutor_x_tution_management/data/nav_entry.dart';
import 'package:tutor_x_tution_management/models/menu_model.dart';
import 'package:tutor_x_tution_management/routes/route.dart';

typedef ItemTap = void Function()?;

class NavBuildEntry extends StatefulWidget {
  const NavBuildEntry({super.key});

  @override
  State<NavBuildEntry> createState() => _NavBuildEntryState();
}

class _NavBuildEntryState extends State<NavBuildEntry> {
  @override
  Widget build(BuildContext context) {
    final menuData = NavEntry();
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: menuData.navEntriesForStudent.length,
      itemBuilder: (context, index) =>
          navMenuEntry(index, menuData.navEntriesForStudent[index], context),
    );
  }

  Widget navMenuEntry(int index, MenuModel menuModel, BuildContext context) {
    final bool isSelected = WebRoutes.webNavigationBarIndex == index;
    return NavigationTile(
      text: menuModel.text,
      onTap: () {
        switch (index) {
          case 0:
            Get.toNamed(WebRoutes.homePage);
            break;
          case 1:
            Get.toNamed(WebRoutes.tutorsPage);
            break;
          case 2:
            Get.toNamed(WebRoutes.tutionsPage);
            break;
          case 3:
            Get.toNamed(WebRoutes.resourcePage);
            break;
          case 4:
            Get.toNamed(WebRoutes.aboutPage);
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
