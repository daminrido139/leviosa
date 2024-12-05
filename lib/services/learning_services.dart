import 'package:cloud_firestore/cloud_firestore.dart';

class LearningServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //[gif, png]
  static Future<List<Map<String, dynamic>>> fetchLetters() async {
    final snaps = await _firestore
        .collection('learning')
        .doc('letters')
        .collection('gujarati')
        .get();
    List<QueryDocumentSnapshot> vowels = [];
    for (QueryDocumentSnapshot doc in snaps.docs) {
      if (doc.id[0] == 'v') {
        vowels.add(doc);
      }
    }
    vowels.sort((a, b) => a.id.compareTo(b.id));
    return vowels.map((v) => v.data() as Map<String, dynamic>).toList();
  }
}
