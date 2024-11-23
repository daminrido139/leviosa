import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> sendMessage(
    String senderUid,
    String receiverUid,
    String senderName,
    String message,
    String? replyTo,
    bool isMyReply,
  ) async {
    final nowTime = Timestamp.now();
    final school = senderUid.split('@')[1].split('.')[0];
    final ids = [senderUid, receiverUid];
    ids.sort();
    final senderPath = _firestore
        .collection("school")
        .doc(school)
        .collection("users")
        .doc(senderUid)
        .collection("chat_info")
        .doc(receiverUid);
    final receiverPath = _firestore
        .collection("school")
        .doc(school)
        .collection("users")
        .doc(receiverUid)
        .collection("chat_info")
        .doc(senderUid);

    final receiverData = (await receiverPath.get()).data();
    final int receiverCount = receiverData?['count'] ?? 0;
    senderPath.set(
      {
        'lastMessage': message,
        'lastMessageTime': nowTime,
        'count': 0,
        'seen': false,
        'lastMessageUID': senderUid,
      },
    );
    receiverPath.set(
      {
        'lastMessage': message,
        'lastMessageTime': nowTime,
        'count': receiverCount + 1,
        'seen': true,
        'lastMessageUID': senderUid,
      },
    );

    _firestore
        .collection("school")
        .doc(school)
        .collection("chats")
        .doc(ids.join("-"))
        .collection("chats")
        .add({
      "sender_id": senderUid,
      "message": message,
      "time": nowTime,
      "reply_to": replyTo,
      "seen": false,
      "is_my_reply": isMyReply,
    });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> receiveMessage(
      String senderUid, String receiverUid, int limit) {
    final school = senderUid.split('@')[1].split('.')[0];
    final ids = [senderUid, receiverUid];
    ids.sort();
    return _firestore
        .collection("school")
        .doc(school)
        .collection("chats")
        .doc(ids.join("-"))
        .collection("chats")
        .orderBy("time", descending: true)
        .limit(limit)
        .snapshots();
  }
}
