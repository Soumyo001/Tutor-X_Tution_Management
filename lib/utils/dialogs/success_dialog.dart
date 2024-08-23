import 'package:flutter/material.dart';
import 'package:tutor_x_tution_management/utils/generics/generic_dialog.dart';

Future<bool> showSuccessDialog(BuildContext context, String text) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Success !',
    content: text,
    dialogOptionBuilder: () => {
      'ok': null,
    },
  ).then((value) => value ?? false);
}
