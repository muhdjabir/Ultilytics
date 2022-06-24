/*
Features to include
App Bar opponent
Game Details
List of Players
Player stats
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/models/Game.dart';
import 'package:orbital_ultylitics/models/Player.dart';

class GameSummaryScreen extends StatelessWidget {
  final Game game;
  final String docID;

  Stream<QuerySnapshot> getPlayerStats() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String uid = user!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('games')
        .doc(docID)
        .collection('players')
        .snapshots();
  }

  const GameSummaryScreen({
    Key? key,
    required this.game,
    required this.docID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> players = getPlayerStats();
    print("${game.teamName} vs ${game.opponentName}");
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("${game.teamName} vs ${game.opponentName}"),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: players,
            builder: (context, snapshot) {
              if (snapshot.hasData || snapshot.data != null) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      QueryDocumentSnapshot<Object?>? documentSnapshot =
                          snapshot.data?.docs[index];
                      Player player = Player.fromSnapshot(documentSnapshot);
                      return (documentSnapshot != null)
                          ? Card(
                              elevation: 4,
                              child: ListTile(
                                  tileColor: Color.fromARGB(255, 10, 52, 87),
                                  textColor: Colors.deepPurpleAccent,
                                  title: Text(player.name.toString())))
                          : Text("No Players");
                    });
              } else {
                return Text("No Players");
              }
            }));
  }
}
