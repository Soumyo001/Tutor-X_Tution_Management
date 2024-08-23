import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'package:tutor_x_tution_management/data/enums.dart';

class ProfileEditSM extends StatefulWidget {
  final bool isTutor;
  const ProfileEditSM({super.key, this.isTutor = true});

  @override
  State<ProfileEditSM> createState() => _ProfileEditSMState();
}

class _ProfileEditSMState extends State<ProfileEditSM> {
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
          'Student Medium :',
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
                widget.isTutor
                    ? _userStaticsController.tutor!.mediumOfInterest
                        .toString()
                        .split('.')
                        .last
                        .replaceAll('_', ' ')
                    : _userStaticsController.student!.studentMedium
                        .toString()
                        .split('.')
                        .last
                        .replaceAll('_', ' '),
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: StudentMedium.values
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
              value: widget.isTutor
                  ? _userStaticsController.tutorStudentMedium
                  : _userStaticsController.studentMedium,
              onChanged: (value) {
                if (widget.isTutor) {
                  _userStaticsController.tutorStudentMedium = value!;
                  _userStaticsController.tutor!.mediumOfInterest = value;
                } else {
                  _userStaticsController.studentMedium = value!;
                  _userStaticsController.student!.studentMedium = value;
                }
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
