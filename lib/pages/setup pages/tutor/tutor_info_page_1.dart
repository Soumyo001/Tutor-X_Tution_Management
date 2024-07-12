import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:tutor_x_tution_management/components/registration_tutor_availability_status.dart';

class TutorInfo1 extends StatefulWidget {
  final void Function(int) change;
  const TutorInfo1({
    super.key,
    required this.change,
  });

  @override
  State<TutorInfo1> createState() => _TutorInfo1State();
}

class _TutorInfo1State extends State<TutorInfo1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const RegistrationAvailabilityStatus(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {
                  widget.change(0);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(24),
                  backgroundColor: const Color.fromARGB(255, 17, 73, 230),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  foregroundColor: Colors.amberAccent.shade100,
                ),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                label: const Text(
                  'Go Back',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  widget.change(2);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(24),
                  backgroundColor: Colors.amber.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  foregroundColor: Colors.amberAccent.shade100,
                ),
                icon: const SizedBox.shrink(),
                label: const Row(
                  children: [
                    Text(
                      'Go next',
                      style: TextStyle(color: Colors.black),
                    ),
                    Gap(8),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
