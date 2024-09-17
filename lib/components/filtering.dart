import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/utils/color_pallete.dart';
import 'package:tutor_x_tution_management/components/filter_item_widget.dart';
import 'package:tutor_x_tution_management/components/filter_widget.dart';
import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:tutor_x_tution_management/data/irl_locations.dart';

class Filtering extends StatefulWidget {
  final String text;
  final void Function()? onFilter;
  const Filtering({super.key, required this.onFilter, required this.text});

  @override
  State<Filtering> createState() => _FilteringState();
}

class _FilteringState extends State<Filtering> {
  final Rx<String?> _selectedValueArea = Rx<String?>(null);
  final Rx<String?> _selectedValueMedium = Rx<String?>(null);
  final Rx<String?> _selectedValueClass = Rx<String?>(null);
  final Rx<String?> _selectedValueSubject = Rx<String?>(null);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(16),
      height: screenSize.height * 0.4,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Pallete.gradiant9, Pallete.buttonColor],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
                const Gap(60),
                FilterWidget(
                  filterItems: [
                    FilterItem(
                      filterOptionName: 'Area: ',
                      haveSearchBar: true,
                      items: IRLocations.location,
                      selectedValue: _selectedValueArea,
                    ),
                    const Gap(15),
                    FilterItem(
                      filterOptionName: 'Medium: ',
                      haveSearchBar: false,
                      items: StudentMedium.values
                          .map((e) =>
                              e.toString().split('.').last.replaceAll('_', ' '))
                          .toList(),
                      selectedValue: _selectedValueMedium,
                      enumName: StudentMedium,
                    ),
                    const Gap(15),
                    FilterItem(
                      filterOptionName: 'Class: ',
                      haveSearchBar: false,
                      items: StudentTypes.values
                          .map((e) => e
                              .toString()
                              .split('.')
                              .last
                              .replaceAll('_', ' ')
                              .replaceAll('to', '-'))
                          .toList(),
                      selectedValue: _selectedValueClass,
                      enumName: StudentTypes,
                    ),
                    const Gap(15),
                    FilterItem(
                      filterOptionName: 'Subject: ',
                      haveSearchBar: false,
                      items: SubjectTypes.values
                          .map((e) =>
                              e.toString().split('.').last.replaceAll('_', ' '))
                          .toList(),
                      selectedValue: _selectedValueSubject,
                      enumName: SubjectTypes,
                    ),
                  ],
                ),
                const Gap(30),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: widget.onFilter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Pallete.buttonColor,
                      padding: const EdgeInsets.all(18),
                    ),
                    child: const Text(
                      'Search by Filtering',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
