import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'package:tutor_x_tution_management/data/enums.dart';

class ProfileEditST extends StatefulWidget {
  const ProfileEditST({super.key});

  @override
  State<ProfileEditST> createState() => _ProfileEditSTState();
}

class _ProfileEditSTState extends State<ProfileEditST> {
  late final UserStaticsController _userStaticsController;
  @override
  void initState() {
    super.initState();
    _userStaticsController = Get.find<UserStaticsController>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Student Type :',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
            fontSize: 18,
          ),
        ),
        const Gap(5),
        Obx(
          () => DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint: Text(
                _userStaticsController.tutor!.expectedStudent
                    .toString()
                    .split('.')
                    .last
                    .replaceAll('_', ' ')
                    .replaceAll('to', '-'),
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: StudentTypes.values
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item
                              .toString()
                              .split('.')
                              .last
                              .replaceAll('_', ' ')
                              .replaceAll('to', '-'),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              value: _userStaticsController.tutorStudentType,
              onChanged: (value) {
                _userStaticsController.tutorStudentType = value!;
                _userStaticsController.tutor!.expectedStudent = value;
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 200,
              ),
              dropdownStyleData: const DropdownStyleData(
                maxHeight: 200,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
