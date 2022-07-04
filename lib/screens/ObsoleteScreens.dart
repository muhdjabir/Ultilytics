/*class GameSummaryScreen extends StatelessWidget {
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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: false,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("${game.teamName} vs ${game.opponentName}"),
        ),
        body: Column(children: <Widget>[
          Text(
            "${game.myScore} - ${game.opponentScore}",
            textAlign: TextAlign.center,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text("Name",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            Text("Scores",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            Text("Assists",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            Text("Throwaways",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)))
          ]),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: players,
                  builder: (context, snapshot) {
                    if (snapshot.hasData || snapshot.data != null) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            QueryDocumentSnapshot<Object?>? documentSnapshot =
                                snapshot.data?.docs[index];
                            Player player =
                                Player.fromSnapshot(documentSnapshot);
                            return Card(
                              /*elevation: 4,
                                child: Row(
                                  children: [
                                    Text(player.name.toString()),
                                    Text(player.assists.toString()),
                                    Text(player.catches.toString())
                                  ],*/
                              child: ListTile(
                                  tileColor: Color.fromARGB(255, 10, 52, 87),
                                  textColor: Colors.deepPurpleAccent,
                                  title: Text(player.name.toString()),
                                  onTap: () => print("HI")),
                            );
                          });
                    } else {
                      return Text("No Players");
                    }
                  }))
        ]));
  }
}
*/

/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/models/Game.dart';
import 'package:orbital_ultylitics/models/Player.dart';
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
    //var gamesData = getGamesHistory(uid);
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
                    String? docID = documentSnapshot?.reference.id;
                    return Card(
                        elevation: 4,
                        child: ListTile(
                            tileColor: Color.fromARGB(255, 10, 52, 87),
                            textColor: Colors.white,
                            title: Text(game.teamName.toString()),
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

*/