import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/Material.dart';

class AddPostDropDown<T extends Enum> extends StatelessWidget {
  final String text;
  final List<T> values;
  final T value;
  final void Function(T?) onChanged;
  const AddPostDropDown({
    super.key,
    required this.text,
    required this.values,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton2<T>(
              items: values
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item
                              .toString()
                              .split('.')
                              .last
                              .replaceAll('_', ' ')
                              .replaceAll('to', '-'),
                        ),
                      ))
                  .toList(),
              value: value,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
