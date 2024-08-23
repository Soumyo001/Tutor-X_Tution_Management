import 'package:flutter/material.dart';
import 'package:tutor_x_tution_management/utils/generics/generic_dialog.dart';

Future<bool> showConfirmationDialog(BuildContext context, String title,
    {String acceptString = 'Accept', String declineString = 'Decline'}) {
  return showGenericDialog<bool>(
    context: context,
    title: title,
    content: '',
    dialogOptionBuilder: () => {
      acceptString: true,
      declineString: false,
    },
  ).then((value) => value ?? false);
}
