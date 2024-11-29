import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SondageScreen extends StatelessWidget {
  const SondageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(96.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                vote("Windows");
              },
              child: Row(
                children: [
                  Icon(Icons.window),
                  Text('Windows'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                vote("Apple");
              },
              child: Row(
                children: [
                  Icon(Icons.apple),
                  Text('Apple'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: Text('Déconnexion'),
            )
          ],
        ),
      ),
    );
  }

  Future vote(String selection) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference collection = db.collection("sondage");
    QuerySnapshot snapshot = await collection.get();
    List<QueryDocumentSnapshot> list = snapshot.docs;
    DocumentSnapshot document = list.first;
    final id = document.id;
    if (selection == "Windows") {
      int windowsVotes = document.get('windows');
      collection.doc(id).update({"windows": ++windowsVotes});
    } else if (selection == "Apple") {
      int appleVotes = document.get('apple');
      collection.doc(id).update({"apple": ++appleVotes});
    }
  }
}
