import 'package:flutter/Material.dart';
import 'package:tutor_x_tution_management/utils/generics/generic_dialog.dart';

Future<void> showTitleErrorDialog(
    BuildContext context, String title, String text) {
  return showGenericDialog<void>(
    context: context,
    title: title,
    content: text,
    dialogOptionBuilder: () => {
      'OK': null,
    },
  );
}
