//implement themedata
//fix the view for this page refer to this video https://www.youtube.com/watch?v=k1LxTsmAURU

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../NavigationBarScreen.dart';

class CreateTeamScreen extends StatefulWidget {
  final String newTeamName;
  const CreateTeamScreen({Key? key, required this.newTeamName})
      : super(key: key);
  @override
  State<CreateTeamScreen> createState() =>
      _CreateTeamScreenState(newTeamName: this.newTeamName);
}

Future<void> insertPlayerData(
    //Creates Team Collection in Firebase
    final newTeamName,
    final newPlayerName,
    final uid) async {
  CollectionReference usersCollectionRef =
      FirebaseFirestore.instance.collection('users');
  usersCollectionRef.doc(uid).collection('teams').doc(newTeamName).set({
    "Players": FieldValue.arrayUnion([newPlayerName])
    //"Number of Players": FieldValue.increment(1),
  }, SetOptions(merge: true));
  usersCollectionRef
      .doc(uid)
      .collection('teams')
      .doc(newTeamName)
      .collection('players')
      .doc(newPlayerName)
      .set({
    "Player Name": newPlayerName,
    "Catch": 0,
    "Assists": 0,
    "Throwaways": 0,
    "Goals Scored": 0,
    "Total Throws": 0,
    "Interception": 0,
    "Points Played": 0,
    "Advantageous Throw": 0,
    "Number of Pulls": 0,
    "Plus-Minus": 0,
    "Stalled Out": 0,
    "Average Pull Time": 0,
    "Out of Bounds Pull": 0,
    "Average Disc Time": 0,
    "Drops": 0,
    "Touches": 0,
  });
}

enum Menu { removePlayer, editName }

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  List<String> _playerList = [];
  String newTeamName;
  _CreateTeamScreenState({required this.newTeamName});
  late TextEditingController controllerPlayerName;
  String _newPlayerName = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  void initState() {
    super.initState();
    controllerPlayerName = TextEditingController();
  }

  Future<void> getTeamSize(final newTeamName, final uid) async {
    var teamSize = 0;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('teams')
        .doc(newTeamName)
        .collection('players')
        .get()
        .then(
          (snapshot) => {
            snapshot.docs.forEach(
              (document) {
                _playerList.add(document.reference.id);
                print(document.reference.id);
                //teamSize += 1;
              },

              //teamSize = _playerList.length
            )
          },
        )
        .then((value) {
      teamSize = _playerList.length;
      //print('$teamSize size of team');
      CollectionReference usersCollectionRef =
          FirebaseFirestore.instance.collection('users');
      usersCollectionRef.doc(uid).set({
        "Teams": FieldValue.arrayUnion([newTeamName])
      }, SetOptions(merge: true));
      usersCollectionRef
          .doc(uid)
          .collection('teams')
          .doc(newTeamName)
          .update({"Number of Players": teamSize});
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('teams')
          .doc(newTeamName)
          .update({"Players": _playerList});
    });
  }

  Future<void> insertTeamData(final newTeamName, final uid, teamSize) async {
    getTeamSize(newTeamName, uid).then((value) {
      //teamSize = _playerList.length;
      //print('$teamSize size of team');
      CollectionReference usersCollectionRef =
          FirebaseFirestore.instance.collection('users');
      usersCollectionRef.doc(uid).set({
        "Teams": FieldValue.arrayUnion([newTeamName])
      }, SetOptions(merge: true));
      usersCollectionRef
          .doc(uid)
          .collection('teams')
          .doc(newTeamName)
          .update({"Number of Players": teamSize});
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          newTeamName,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 20.0,
              color: Color.fromARGB(255, 110, 148, 252),
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color.fromARGB(255, 4, 36, 52),
      ),
      backgroundColor: Colors.black45,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .collection('teams')
                      .doc(newTeamName)
                      .collection('players')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            QueryDocumentSnapshot<Object?>? documentSnapshot =
                                snapshot.data?.docs[index];
                            //return Dismissible(
                            return ListTile(
                                // this is likely the problem for why it doesnt scroll properly
                                title: Text(
                                    (documentSnapshot != null)
                                        ? (documentSnapshot["Player Name"])
                                        : "",
                                    style: const TextStyle(color: Colors.grey)),
                                //color: ,
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.grey,
                                  onPressed: () {
                                    final currTeam = FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(uid)
                                        .collection('teams')
                                        .doc(newTeamName);
                                    //String _playerToDelete = currTeam.collection('Players').doc()[index]
                                    _playerList.remove(
                                        (documentSnapshot != null)
                                            ? (documentSnapshot["Player Name"])
                                            : "");
                                    currTeam
                                        .collection('players')
                                        .doc((documentSnapshot != null)
                                            ? (documentSnapshot["Player Name"])
                                            : "")
                                        .delete();
                                  },
                                ));
                          }));
                    } else {
                      return const Text("something is wrong",
                          style: TextStyle(color: Colors.amber));
                    }
                  }),
              Container(
                //width: 100,
                height: 70,
                color: Colors.grey[400],
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                        child: TextFormField(
                          style: const TextStyle(
                              fontSize: 20.0,
                              color: Color.fromARGB(255, 10, 48, 70),
                              fontWeight: FontWeight.w500),
                          controller: controllerPlayerName,
                          onChanged: (val) {
                            setState(() {
                              _newPlayerName = val;
                            });
                          },
                          autofocus: true,
                          obscureText: false,
                          decoration: const InputDecoration(
                            hintText: 'Input name of new player',
                            hintStyle: TextStyle(
                                fontSize: 20.0,
                                color: Color.fromARGB(255, 16, 75,
                                    109) /*Color.fromARGB(255, 56, 75, 128)*/,
                                fontWeight: FontWeight.w500),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      color: const Color.fromARGB(0, 198, 113, 113),
                      splashRadius: 30,
                      //borderWidth: 1,
                      iconSize: 40,
                      icon: const Icon(
                        Icons.add_box_outlined,
                        color: Color.fromARGB(255, 66, 66,
                            66), //FlutterFlowTheme.of(context).secondaryText,
                        size: 30,
                      ),
                      onPressed: () async {
                        final User? user = auth.currentUser;
                        final uid = user!.uid;
                        insertPlayerData(newTeamName, _newPlayerName, uid);
                        controllerPlayerName.clear();
                      },
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: const Text('Done'),
                onPressed: () async {
                  getTeamSize(newTeamName, uid);
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NavigationBarScreen(index: 1),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                    return Colors.blue;
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
