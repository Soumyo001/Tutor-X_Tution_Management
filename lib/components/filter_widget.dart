import 'package:flutter/material.dart';

class FilterWidget extends StatelessWidget {
  final List<Widget> filterItems;
  const FilterWidget({super.key, required this.filterItems});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: filterItems,
    );
  }
}
