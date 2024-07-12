import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class NavigationTile extends StatefulWidget {
  final String text;
  final void Function()? onTap;
  final bool isSelected;
  const NavigationTile({
    super.key,
    required this.text,
    required this.onTap,
    required this.isSelected,
  });

  @override
  State<NavigationTile> createState() => _NavigationTileState();
}

class _NavigationTileState extends State<NavigationTile> {
  RxBool isHover = false.obs;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: widget.isSelected
              ? Colors.white12.withAlpha(50)
              : Colors.transparent),
      child: InkWell(
        onHover: (value) {
          isHover.value = value;
        },
        onTap: widget.onTap,
        splashColor: Colors.transparent,
        hoverColor: Colors.white70,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Gap(25),
                Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 14,
                    color: isHover.value ? Colors.black38 : Colors.black,
                  ),
                ),
                const Gap(5),
                Visibility(
                  maintainAnimation: true,
                  maintainState: true,
                  maintainSize: true,
                  visible: isHover.value || widget.isSelected,
                  child: Container(
                    width: 20,
                    height: 2,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
