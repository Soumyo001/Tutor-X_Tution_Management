import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/utils/color_pallete.dart';
import 'package:tutor_x_tution_management/controllers/filter_controller.dart';

import 'package:tutor_x_tution_management/data/enums.dart';

class GenericFilterDropDown extends StatefulWidget {
  final bool haveSearchBar;
  final List<String> items;
  final Rx<String?> selectedValue;
  final dynamic enumName;

  const GenericFilterDropDown({
    super.key,
    required this.haveSearchBar,
    required this.items,
    required this.selectedValue,
    this.enumName,
  });

  @override
  State<GenericFilterDropDown> createState() => _GenericFilterDropDownState();
}

class _GenericFilterDropDownState extends State<GenericFilterDropDown> {
  late final TextEditingController _areaEditingController;
  late final FilterController _filterController;
  late final List<String> _options;

  @override
  void initState() {
    super.initState();
    _areaEditingController = TextEditingController();
    _filterController = Get.find<FilterController>();
    Set<String> s = Set<String>.from(widget.items);
    _options = List<String>.from(s);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Obx(
        () => DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            'Select Item',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: _options
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          value: widget.selectedValue.value,
          onChanged: (value) {
            widget.selectedValue.value = value;
            if (widget.enumName == null) {
              _filterController.selectedValueArea = value;
            }
            if (value != null) {
              if (widget.enumName == StudentMedium) {
                _filterController.setStudentMedium = value;
              } else if (widget.enumName == StudentTypes) {
                _filterController.setStudentTypes = value;
              } else if (widget.enumName == SubjectTypes) {
                _filterController.setSubjectTypes = value;
              }
            }
          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(color: Colors.white),
            height: 40,
            width: 250,
          ),
          dropdownStyleData: const DropdownStyleData(
            maxHeight: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
          dropdownSearchData: widget.haveSearchBar
              ? DropdownSearchData(
                  searchController: _areaEditingController,
                  searchInnerWidgetHeight: 50,
                  searchInnerWidget: Container(
                    height: 50,
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      controller: _areaEditingController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Search for a location...',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              width: 2, color: Pallete.gradiant9),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return item.value
                        .toString()
                        .toLowerCase()
                        .contains(searchValue.toLowerCase());
                  },
                )
              : null,
          //This to clear the search value when you close the menu
          onMenuStateChange: widget.haveSearchBar
              ? (isOpen) {
                  if (!isOpen) {
                    _areaEditingController.clear();
                  }
                }
              : null,
        ),
      ),
    );
  }
}
