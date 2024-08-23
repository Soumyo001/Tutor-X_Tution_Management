import 'package:flutter/material.dart';
import 'package:tutor_x_tution_management/color_pallete.dart';

class ButtonIcon extends StatelessWidget {
  final String? label;
  final IconData icon;
  final void Function()? onPressed;
  final bool enableIcon;
  final bool loading;
  final Widget? loadingWidget;
  const ButtonIcon({
    super.key,
    this.label,
    required this.icon,
    required this.onPressed,
    required this.enableIcon,
    required this.loading,
    this.loadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    assert((loadingWidget != null && loading == true) ||
        (loadingWidget == null && loading == false));
    return TextButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Pallete.buttonColor,
        foregroundColor: Colors.white10,
        padding: const EdgeInsets.all(12),
      ),
      icon: enableIcon
          ? loading
              ? loadingWidget!
              : Icon(
                  icon,
                  color: Colors.white,
                )
          : const SizedBox.shrink(),
      label: label == null
          ? const SizedBox.shrink()
          : Text(
              label!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
    );
  }
}
