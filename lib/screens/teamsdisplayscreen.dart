import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'package:orbital_ultylitics/screens/HomePage.dart';
import 'package:orbital_ultylitics/screens/CreateTeamScreen.dart';
import 'package:orbital_ultylitics/screens/customWidget/TeamNameWidget.dart';
//import 'package:orbital_ultylitics/screens/profilescreen.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'ProfileScreen.dart';
//import '../namewidget.dart';
//import 'settingscreen.dart';

class TeamsDisplayScreen extends StatefulWidget {
  const TeamsDisplayScreen({Key? key}) : super(key: key);

  @override
  State<TeamsDisplayScreen> createState() => _TeamsDisplayScreenState();
}

Future<void> insertTeamData(final uid, final _newTeamName) async {
  CollectionReference usersCollectionRef =
      FirebaseFirestore.instance.collection('users');
  //DocumentSnapshot = await usersCollectionRef.doc().get();
  usersCollectionRef.doc(uid).collection('teams').doc(_newTeamName).set({
    "Team Name": _newTeamName,
    "Players": <String>[],
    "Number of Players": 0,
    "Wins": 0,
    "Loses": 0,
    "Win Rate": 100,
  });
  //DocumentSnapshot docSnap= await usersCollectionRef.doc().get();
  //String teamDocID = docSnap.reference.documentID;
}

createAlertDialog(BuildContext context) {
  String _newTeamName;
  TextEditingController controllerTeamName = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("New Team Name?"),
          content: TextField(
            controller: controllerTeamName,
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text('Submit'),
              onPressed: () {
                _newTeamName = controllerTeamName.text.toString();
                if (_newTeamName != "") {
                  final User? user = auth.currentUser;
                  final uid = user!.uid;
                  insertTeamData(uid, _newTeamName);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        CreateTeamScreen(newTeamName: _newTeamName),
                  ));
                }
              },
            ),
          ],
        );
      });
}

Future getDocs(String uid) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('teams')
      .get();
  final allData =
      querySnapshot.docs.map((doc) => doc.get('Team Name')).toList();
  return allData;
}

class _TeamsDisplayScreenState extends State<TeamsDisplayScreen> {
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
    //var teamsDataSnapshot = FirebaseFirestore.instance.collection('users').doc(uid).collection('teams').get();
    var teamsData = getDocs(uid);
    //CollectionReference usersCollectionRef =
    //FirebaseFirestore.instance.collection('teams');
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            //add new team button
            icon: const Icon(Icons.group_add_outlined),
            onPressed: () async {
              createAlertDialog(context);
            },
          ),
        ],
        title: const Text("Your Teams"),
      ),
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
                      print(snapshot.data!.docs.length);
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot<Object?>? documentSnapshot =
                                snapshot.data?.docs[index];
                            print(teamsData);
                            //var currTeams = teams;
                            return NameContainerWidget(
                                child: documentSnapshot!["Team Name"]);
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
    );
  }
}
