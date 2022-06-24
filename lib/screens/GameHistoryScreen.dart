//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/models/Game.dart';
import 'package:orbital_ultylitics/screens/customWidget/GameEntryWidget.dart';
//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/framework.dart';

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
                    return (documentSnapshot != null)
                        ? Card(
                            elevation: 4,
                            child: ListTile(
                                tileColor: Color.fromARGB(255, 10, 52, 87),
                                textColor: Colors.deepPurpleAccent,
                                title: Text(documentSnapshot["My Team"]),
                                subtitle: Text(documentSnapshot["Opponents"]),
                                leading: Text(
                                    documentSnapshot["My Score"].toString()),
                                trailing: Text(
                                    documentSnapshot["Opponent Score"]
                                        .toString()),
                                onTap: () => print("See More")))
                        : Text("No Games Recorded");
                  },
                );
              } else {
                return Text("No Games Recorded");
              }
            }

            /*SafeArea(
        child: Expanded(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Expanded(child:
                StreamBuilder<QuerySnapshot>(
                  //https://www.youtube.com/watch?v=HDy0RKCj40Q
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .collection('games')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data!.docs.length);
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot<Object?>? documentSnapshot =
                                snapshot.data?.docs[index];
                            print(gamesData);
                            //var currTeams = teams;
                            return GameEntryWidget(
                                child: documentSnapshot!["Game Details"]);
                          });
                    } else {
                      return const Text("something is wrong",
                          style: TextStyle(color: Colors.amber));
                    }
                  },
                ) //),
              ],
            ),
            //)
          ),
        ),
      ),*/
            ));
  }
}
