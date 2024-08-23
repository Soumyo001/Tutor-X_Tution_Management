import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TutorProfileExtraInfo extends StatelessWidget {
  final String extraInfo;
  final String label;
  final double? labelFontSize, extraInfoFontSize;
  final Color? labelColor, extraInfoColor;
  const TutorProfileExtraInfo({
    super.key,
    required this.extraInfo,
    required this.label,
    this.labelFontSize = 18,
    this.extraInfoFontSize = 15,
    this.labelColor = Colors.grey,
    this.extraInfoColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: labelColor,
              fontWeight: FontWeight.w500,
              fontSize: labelFontSize,
            ),
          ),
          const Gap(5),
          Text(
            extraInfo,
            maxLines: null,
            style: TextStyle(
              color: extraInfoColor,
              fontSize: extraInfoFontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
