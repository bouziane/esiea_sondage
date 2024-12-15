import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sondage/votes.dart';

class FirebaseRepository {
  static Future<Votes> getVotes() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('sondage').limit(1).get();
      Map<String, dynamic> data = querySnapshot.docs.first.data() as Map<String, dynamic>;

      return Votes(
        windows: data['windows'] ?? 0, 
        apple: data['apple'] ?? 0,
      );
    } catch (e) {
      rethrow; 
    }
  }

  static Future saveVotes(Votes votes) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('sondage').limit(1).get();
      DocumentReference votesDoc = querySnapshot.docs.first.reference;

      await votesDoc.update({
        'windows': votes.windows,
        'apple': votes.apple,
      });
    } catch (e) {
      rethrow; 
    }
  }
}