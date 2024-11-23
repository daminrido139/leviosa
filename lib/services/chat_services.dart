import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leviosa/model/user_model.dart';

class ChatServices {
  static final _firestore = FirebaseFirestore.instance;

  static final Map<String, UserModel> _userCache = {};

  static void cacheUser(String userId, UserModel user) {
    if (_userCache.containsKey(userId)) return;
    _userCache[userId] = user;
  }

  static UserModel? getUserCache(String userId) {
    if (_userCache.containsKey(userId)) return _userCache[userId];
    return null;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> listenChats(
    String senderUid,
  ) {
    final school = senderUid.split('@')[1].split('.')[0];
    return _firestore
        .collection("school")
        .doc(school)
        .collection("users")
        .doc(senderUid)
        .collection('chat_info')
        .orderBy(
          'lastMessageTime',
          descending: true,
        )
        .snapshots();
  }

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

  static Future<void> setCountZero(String userId, String otherId) async {
    final school = userId.split('@')[1].split('.')[0];

    _firestore
        .collection("school")
        .doc(school)
        .collection("users")
        .doc(userId)
        .collection("chat_info")
        .doc(otherId)
        .set(
      {"count": 0},
      SetOptions(merge: true),
    );
  }

  static Future<void> setMessageSeen(
      String messageId, String senderUid, String receiverUid) async {
    final school = senderUid.split('@')[1].split('.')[0];
    final ids = [senderUid, receiverUid];
    ids.sort();
    final String chatRoomId = ids.join("-");
    _firestore
        .collection("school")
        .doc(school)
        .collection("chats")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(
      {"seen": true},
      SetOptions(merge: true),
    );
  }

  static Future<void> setMessageSeenAtChatInfo(
      String senderUid, String receiverUid) async {
    final school = senderUid.split('@')[1].split('.')[0];
    _firestore
        .collection("school")
        .doc(school)
        .collection("users")
        .doc(senderUid)
        .collection("chat_info")
        .doc(receiverUid)
        .set(
      {"seen": true},
      SetOptions(merge: true),
    );
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
