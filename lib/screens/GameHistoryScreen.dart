import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/models/Game.dart';
import 'package:orbital_ultylitics/screens/GameSummaryScreen.dart';
import 'package:orbital_ultylitics/screens/customWidget/GameEntryWidget.dart';
import 'HomePage.dart';

class GameHistoryScreen extends StatefulWidget {
  const GameHistoryScreen({Key? key}) : super(key: key);

  @override
  State<GameHistoryScreen> createState() => _GameHistoryScreenState();
}

Future getGamesHistory(String uid) async {
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
    var gamesData = getGamesHistory(uid);
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("Game History"),
        ),
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
                    return (documentSnapshot != null)
                        ? Card(
                            elevation: 4,
                            child: ListTile(
                                tileColor: Color.fromARGB(255, 10, 52, 87),
                                textColor: Colors.deepPurpleAccent,
                                title: Text(game.teamName
                                    .toString()), //documentSnapshot["My Team"]),
                                subtitle: Text(game.opponentName
                                    .toString()), //documentSnapshot["Opponents"]),
                                leading: Text(game.myScore
                                    .toString()), //documentSnapshot["My Score"].toString()),
                                trailing: Text(game.opponentScore
                                    .toString()), //documentSnapshot["Opponent Score"]
                                //  .toString()),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        GameSummaryScreen(game: game),
                                  ));
                                }))
                        //=> print("See More")))
                        : Text("No Games Recorded");
                  },
                );
              } else {
                return Text("No Games Recorded");
              }
            }));
  }
}
