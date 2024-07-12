import 'package:flutter/Material.dart';
import 'package:tutor_x_tution_management/utils/generics/generic_dialog.dart';

Future<void> showErrorDialog2(BuildContext context, String text) {
  return showGenericDialog<void>(
    context: context,
    title: 'One or more info is missing or incorrect',
    content: text,
    dialogOptionBuilder: () => {
      'OK': null,
    },
  );
}
