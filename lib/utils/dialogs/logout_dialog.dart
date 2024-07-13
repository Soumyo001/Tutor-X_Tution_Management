import 'package:flutter/material.dart';
import 'package:tutor_x_tution_management/utils/generics/generic_dialog.dart';

Future<bool> showLogoutDialog(BuildContext context, String text) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Logout',
    content: text,
    dialogOptionBuilder: () => {
      'Yes': true,
      'No': false,
    },
  ).then((value) => value ?? false);
}
