import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/models/Game.dart';
import 'package:orbital_ultylitics/screens/Histories/GameSummaryScreen.dart';

class GameHistoryScreen extends StatefulWidget {
//  const GameHistoryScreen({Key? key}) : super(key: key);

  @override
  State<GameHistoryScreen> createState() => _GameHistoryScreenState();
}

Future getGamesHistory(String uid) async {
  // Acquiring individual player statistics from this game
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('games')
      .get();
  final allData =
      querySnapshot.docs.map((doc) => doc.get('Team Name')).toList();
  return allData;
}

class _GameHistoryScreenState extends State<GameHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    final Stream<QuerySnapshot> games = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('games')
        .snapshots();
    //var gamesData = getGamesHistory(uid);
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        body: StreamBuilder<QuerySnapshot>(
            stream: games,
            builder: (context, snapshot) {
              if (snapshot.hasData || snapshot.data != null) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    QueryDocumentSnapshot<Object?>? documentSnapshot =
                        snapshot.data?.docs[index];
                    Game game = Game.fromSnapshot(documentSnapshot);
                    String? docID = documentSnapshot?.reference.id;
                    return Card(
                        elevation: 4,
                        child: ListTile(
                            tileColor: Color.fromARGB(255, 10, 52, 87),
                            textColor: Colors.white,
                            title: Text(
                                "${game.teamName.toString()} ${game.gameType.toString()}"),
                            subtitle:
                                Text("VS ${game.opponentName.toString()}"),
                            trailing: Text(
                                "${game.myScore} - ${game.opponentScore.toString()}"),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => GameSummaryScreen(
                                    game: game, docID: docID.toString()),
                              ));
                            }));
                  },
                );
              } else {
                return Text("No Games Recorded");
              }
            }));
  }
}
