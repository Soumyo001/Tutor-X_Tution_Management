import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:tutor_x_tution_management/components/generic_drop_down_widget.dart';

class FilterItem extends StatelessWidget {
  final String filterOptionName;
  final bool haveSearchBar;
  final List<String> items;
  final Rx<String?> selectedValue;
  final dynamic enumName;
  const FilterItem({
    super.key,
    required this.filterOptionName,
    required this.haveSearchBar,
    required this.items,
    required this.selectedValue,
    this.enumName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          filterOptionName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 15,
          ),
        ),
        const Gap(10),
        GenericDropDown(
          haveSearchBar: haveSearchBar,
          items: items,
          selectedValue: selectedValue,
          enumName: enumName,
        ),
      ],
    );
  }
}
