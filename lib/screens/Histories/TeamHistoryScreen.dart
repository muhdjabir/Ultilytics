import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/models/Team.dart';
import 'package:orbital_ultylitics/screens/Histories/TeamSummaryScreen.dart';

class TeamHistoryScreen extends StatefulWidget {
  @override
  State<TeamHistoryScreen> createState() => _TeamHistoryScreenState();
}

class _TeamHistoryScreenState extends State<TeamHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    final Stream<QuerySnapshot> teams = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('teams')
        .snapshots();
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        body: SafeArea(
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
                      .collection('teams')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot<Object?>? documentSnapshot =
                                snapshot.data?.docs[index];
                            Team team = Team.fromSnapshot(documentSnapshot);
                            String? docID = documentSnapshot?.reference.id;
                            return Card(
                              elevation: 4,
                              child: ListTile(
                                  tileColor: Color.fromARGB(255, 10, 52, 87),
                                  textColor: Colors.white,
                                  title: Text(documentSnapshot!["Team Name"]),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => TeamSummaryScreen(
                                          team: team, docID: docID.toString()),
                                    ));
                                  }),
                            );
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
        ));
  }
}
