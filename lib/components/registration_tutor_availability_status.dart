import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:tutor_x_tution_management/color_pallete.dart';
import 'package:tutor_x_tution_management/controllers/enum_controller.dart';
import 'package:tutor_x_tution_management/data/enums.dart';
import 'package:provider/provider.dart';

class RegistrationAvailabilityStatus extends StatefulWidget {
  const RegistrationAvailabilityStatus({super.key});

  @override
  State<RegistrationAvailabilityStatus> createState() =>
      _RegistrationAvailabilityStatusState();
}

class _RegistrationAvailabilityStatusState
    extends State<RegistrationAvailabilityStatus> {
  @override
  Widget build(BuildContext context) {
    final EnumController enumController = Provider.of<EnumController>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: const Text(
            'Are you currently available? ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        const Gap(10),
        DropdownButton<AvailabilityStatus>(
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(
            Icons.arrow_drop_down_rounded,
            color: Pallete.gradiant2,
          ),
          underline: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
          ),
          value: enumController.availabilityStatus,
          items: const [
            DropdownMenuItem(
              value: AvailabilityStatus.notAvailabe,
              child: Text('Not Available'),
            ),
            DropdownMenuItem(
              value: AvailabilityStatus.available,
              child: Text('Available'),
            ),
          ],
          onChanged: (value) {
            enumController.availabilityStatus = value!;
          },
        ),
      ],
    );
  }
}
