import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tutor_x_tution_management/controllers/statics_controller.dart';
import 'package:tutor_x_tution_management/models/messege.dart';
import 'package:tutor_x_tution_management/utils/constants.dart';

class ChatService {
  late final UserStaticsController _userStaticsController;
  ChatService._sharedInstance() {
    _userStaticsController = Get.find<UserStaticsController>();
  }
  static final _shared = ChatService._sharedInstance();
  factory ChatService() => _shared;

  Future<void> sendMessege(int receiverId, String messege) async {
    final List<String> ids = [
      _userStaticsController.userId.toString(),
      receiverId.toString()
    ];
    ids.sort();
    String chatRoomId = ids.join('_');
    final m = Messege(
      messegeId: chatRoomId,
      uidFrom: _userStaticsController.userId,
      uidTo: receiverId,
      messegeText: messege,
      timeStamp: DateTime.now(),
    );
    await FirebaseFirestore.instance
        .collection(fireStoreMessegeTableName)
        .doc(chatRoomId)
        .collection(fireStoreMessegeSubTableName)
        .add(m.toJson());
  }

  Stream<QuerySnapshot> getMesseges(int senderId, int receiverId) {
    final List<String> ids = [senderId.toString(), receiverId.toString()];
    ids.sort();
    final chatRoomId = ids.join('_');
    return FirebaseFirestore.instance
        .collection(fireStoreMessegeTableName)
        .doc(chatRoomId)
        .collection(fireStoreMessegeSubTableName)
        .orderBy(messegeTimeStampColumn, descending: false)
        .snapshots();
  }
}
