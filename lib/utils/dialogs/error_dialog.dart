import 'package:flutter/Material.dart';
import 'package:tutor_x_tution_management/utils/generics/generic_dialog.dart';

Future<void> showErrorDialog(BuildContext context, String text) {
  return showGenericDialog<void>(
    context: context,
    title: 'An Error Occured',
    content: text,
    dialogOptionBuilder: () => {
      'OK': null,
    },
  );
}
