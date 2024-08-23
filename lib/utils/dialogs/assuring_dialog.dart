import 'package:flutter/material.dart';
import 'package:tutor_x_tution_management/utils/generics/generic_dialog.dart';

Future<bool> showAssuringDialog(BuildContext context, String text) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Cancel Request',
    content: text,
    dialogOptionBuilder: () => {
      'Yes': true,
      'No': false,
    },
  ).then((value) => value ?? false);
}
