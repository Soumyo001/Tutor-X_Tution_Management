import 'package:flutter/Material.dart';

class TutorDisplayWidget extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double? fontSize;
  final Color fontColor;
  const TutorDisplayWidget({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 13,
    this.fontColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 270),
      child: Text(
        text,
        maxLines: 2,
        softWrap: true,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: fontColor,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
