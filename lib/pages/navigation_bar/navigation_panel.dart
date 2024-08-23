import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/color_pallete.dart';
import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/pages/navigation_bar/nav_build_entry.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'package:tutor_x_tution_management/routes/route.dart';

class NavigationPanel extends StatefulWidget {
  const NavigationPanel({super.key});

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  late final UserStaticsController _userStaticsController;
  final RxBool isMainPageHovered = false.obs;
  final RxBool isProfileTapped = false.obs;

  @override
  void initState() {
    super.initState();
    _userStaticsController = Get.find<UserStaticsController>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Pallete.gradiant9.withAlpha(200),
            Pallete.gradiant9.withAlpha(160),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onHover: (value) {
              isMainPageHovered.value = value;
            },
            onTap: () {},
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(
                      'lib/assets/icons/logo.png',
                    ),
                  ),
                  const Gap(7),
                  Obx(
                    () => Text(
                      'Tutor-X:Tution Management',
                      style: TextStyle(
                        letterSpacing: 3,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: isMainPageHovered.value
                            ? Colors.white38
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onHover: (value) {
                    isProfileTapped.value = value;
                  },
                  onTap: () {
                    _userStaticsController.userCategory == UserCategory.teacher
                        ? Get.toNamed(WebRoutes.tutorProfilePage)
                        : Get.toNamed(WebRoutes.studentProfilePage);
                  },
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: [
                        const Gap(7),
                        Row(
                          children: [
                            Obx(
                              () => CircleAvatar(
                                radius: 12,
                                backgroundImage:
                                    _userStaticsController.imageData != null
                                        ? MemoryImage(
                                            _userStaticsController.imageData!)
                                        : null,
                                child: _userStaticsController.imageData == null
                                    ? const Icon(Icons.person)
                                    : null,
                              ),
                            ),
                            const Gap(7),
                            Obx(
                              () => Text(
                                _userStaticsController.userName,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: isProfileTapped.value
                                      ? Colors.black38
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(5),
                const VerticalDivider(
                  color: Colors.black,
                  thickness: 1,
                ),
                const Gap(5),
                const NavBuildEntry(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
