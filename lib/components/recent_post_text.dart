import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:tutor_x_tution_management/color_pallete.dart';

class RecentPost extends StatelessWidget {
  final String text;
  final String buttonText;
  final void Function()? onPressed;
  const RecentPost({
    super.key,
    required this.text,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: Pallete.textColor,
                  fontSize: 16,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    colors: [
                      Pallete.gradiant9.withAlpha(200),
                      Pallete.buttonColor,
                    ],
                  ),
                ),
                child: MaterialButton(
                  onPressed: onPressed,
                  padding: const EdgeInsets.all(16),
                  hoverColor: Pallete.gradiant9,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 64.0),
          child: Divider(
            height: 0.5,
            thickness: 0.2,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
