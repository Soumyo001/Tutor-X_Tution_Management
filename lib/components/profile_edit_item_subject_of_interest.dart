import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'package:tutor_x_tution_management/data/enums.dart';

class ProfileEditSOI extends StatefulWidget {
  const ProfileEditSOI({super.key});

  @override
  State<ProfileEditSOI> createState() => _ProfileEditSOIState();
}

class _ProfileEditSOIState extends State<ProfileEditSOI> {
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
          'Subject of Interest',
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
                _userStaticsController.tutor!.subjectOfInterest
                    .toString()
                    .split('.')
                    .last
                    .replaceAll('_', ' '),
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: SubjectTypes.values
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item.toString().split('.').last.replaceAll('_', ' '),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              value: _userStaticsController.tutorSubjectType,
              onChanged: (value) {
                _userStaticsController.tutorSubjectType = value!;
                _userStaticsController.tutor!.subjectOfInterest = value;
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
