import 'package:cloud_firestore/cloud_firestore.dart';

class LearningServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //[gif, png]
  static Future<List<Map<String, dynamic>>> fetchLetters(
      {bool fetchConsonants = false}) async {
    final snaps = await _firestore
        .collection('learning')
        .doc('letters')
        .collection('gujarati')
        .get();
    List<QueryDocumentSnapshot> letters = [];
    for (QueryDocumentSnapshot doc in snaps.docs) {
      if (doc.id[0] == (fetchConsonants ? 'c' : 'v')) {
        letters.add(doc);
      }
    }
    letters.sort((a, b) =>
        int.parse(a.id.substring(1)).compareTo(int.parse(b.id.substring(1))));
    return letters.map((v) => v.data() as Map<String, dynamic>).toList();
  }

  //[gif, png]
  static Future<List<Map<String, dynamic>>> fetchNumbers() async {
    final snaps = await _firestore
        .collection('learning')
        .doc('numbers')
        .collection('gujarati')
        .get();
    List<QueryDocumentSnapshot> numbers = snaps.docs;
    numbers.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
    return numbers.map((v) => v.data() as Map<String, dynamic>).toList();
  }
}
