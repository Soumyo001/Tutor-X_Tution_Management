import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/Material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/color_pallete.dart';
import 'package:tutor_x_tution_management/components/chat_bubble.dart';
import 'package:tutor_x_tution_management/components/input_box2.dart';
import 'package:tutor_x_tution_management/components/just_icon.dart';
import 'package:tutor_x_tution_management/components/messege_page_reciever.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'package:tutor_x_tution_management/models/student.dart';
import 'package:tutor_x_tution_management/models/tutor.dart';
import 'package:tutor_x_tution_management/models/user.dart';
import 'package:tutor_x_tution_management/service/chat/chat_service.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

class MessegePage extends StatefulWidget {
  const MessegePage({super.key});

  @override
  State<MessegePage> createState() => _MessegePageState();
}

class _MessegePageState extends State<MessegePage> {
  late final TextEditingController _editingController;
  late final UserStaticsController _userStaticsController;
  late final User user;
  late final Tutor? tutor;
  late final Student? student;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
    _userStaticsController = Get.find<UserStaticsController>();
    final arguments = Get.arguments as Map<String, dynamic>;
    user = arguments['user'] as User;
    tutor = arguments['tutor'] as Tutor?;
    student = arguments['student'] as Student?;
  }

  Widget _messegeInput() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InputBox2(
              hintText: 'Type something...',
              controller: _editingController,
              fontSize: 15,
              maxLength: null,
              maxLines: 1,
              customColor: Colors.grey.shade600,
              customFocusColor: Colors.grey.shade400,
            ),
          ),
        ),
        const Gap(3),
        JustIcon(
          icon: Icons.send,
          onPressed: () async {
            if (_editingController.text.isNotEmpty) {
              await ChatService()
                  .sendMessege(user.userId, _editingController.text);
              _editingController.clear();
            }
          },
        ),
      ],
    );
  }

  Widget _messegeItem(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    final int uidFrom = data[messegeUidFromColumn] as int;
    final alignment = uidFrom == _userStaticsController.userId
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: alignment,
        child: ChatBubble(
          isFromSender: uidFrom == _userStaticsController.userId,
          messege: data[messegeTextColumn] as String,
        ),
      ),
    );
  }

  Widget _messegeList() {
    return StreamBuilder(
      stream:
          ChatService().getMesseges(_userStaticsController.userId, user.userId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Pallete.gradiant4, Pallete.gradiant6],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.report_gmailerrorred,
                  size: 30,
                ),
                const Gap(10),
                Text(
                  'Error : ${snapshot.error.toString()}',
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ],
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: snapshot.data!.docs.map((e) => _messegeItem(e)).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        children: [
          MessegeReciever(
            user: user,
            tutor: tutor,
            student: student,
          ),
          const Gap(10),
          Expanded(
            child: _messegeList(),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: _messegeInput(),
          ),
          const Gap(15),
        ],
      ),
    );
  }
}
