import 'package:flutter/material.dart';
import 'package:tutor_x_tution_management/color_pallete.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder dialogOptionBuilder,
}) {
  final options = dialogOptionBuilder();
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        actions: options.keys.map((e) {
          final value = options[e];
          return TextButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.tertiary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              if (value != null) {
                Navigator.of(context).pop(value);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(
              e,
              style: const TextStyle(
                color: Pallete.backgroundColor,
              ),
            ),
          );
        }).toList(),
      );
    },
  );
}
