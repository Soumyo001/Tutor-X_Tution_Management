import 'package:flutter/Material.dart';
import 'package:tutor_x_tution_management/color_pallete.dart';

class ChatBubble extends StatelessWidget {
  final String messege;
  final bool isFromSender;
  const ChatBubble(
      {super.key, required this.messege, required this.isFromSender});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(maxWidth: screenSize.width * 0.3),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isFromSender ? Pallete.buttonColor : Colors.grey.shade700,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        messege,
        textAlign: isFromSender ? TextAlign.end : TextAlign.start,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
