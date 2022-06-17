//implement themedata
//fix the view for this page refer to this video https://www.youtube.com/watch?v=k1LxTsmAURU

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:orbital_ultylitics/namewidget.dart';
import 'package:orbital_ultylitics/screens/settingscreen.dart';
import 'ProfileScreen.dart';

class CreateTeamScreen extends StatefulWidget {
  final String newTeamName;
  const CreateTeamScreen({Key? key, required this.newTeamName})
      : super(key: key);
  @override
  State<CreateTeamScreen> createState() =>
      _CreateTeamScreenState(newTeamName: this.newTeamName);
}

Future<void> insertPlayerData(
    final newTeamName, final newPlayerName, final uid) async {
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
    "Breakside Throws": 0,
    "Openside Throws": 0,
    "Interception": 0,
  });
}

enum Menu { removePlayer, editName }

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  List<String> _playerList = [];
  String newTeamName;
  //PlayersRecord playerName;
  _CreateTeamScreenState({required this.newTeamName});
  late TextEditingController controllerPlayerName;
  String _newPlayerName = "";
  //late String newTeamName;
  //late TextEditingController controllerTeamName;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  //String _selectedMenu = '';
  void initState() {
    super.initState();
    //controllerTeamName = TextEditingController();
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
      print('$teamSize size of team');
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
      print('$teamSize size of team');
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

  //List<String> _playerList = [];
// USE BELOW FOR WHEN EDITING AN EXISTING TEAM (To get back the list of players to be edited)
  //Future<Map<String, dynamic>?> _playerList = FirebaseFirestore.instance.collection('users').doc(uid).collection('teams').doc(newTeamName).get().then((value) => value.data(););

/*  getPlayerList(int teamSize, DocumentReference<Map<String, dynamic>> currTeam) async{
    for (int i = 0; i < teamSize; i += 1){
      _playerList.add(currTeam.collection('Players').doc().id);
    }
  }*/
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
        backgroundColor: Color.fromARGB(255, 4, 36, 52),
      ),
      backgroundColor: Colors.black45,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  //https://www.youtube.com/watch?v=HDy0RKCj40Q
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .collection('teams')
                      .doc(newTeamName)
                      .collection('players')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //print("hasdata");
                      //print(snapshot.data!.docs.length);

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
                                    style: TextStyle(color: Colors.grey)),
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
                      return Text("something is wrong",
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
                        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
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
                      color: Color.fromARGB(0, 198, 113, 113),
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
                        _playerList.add(_newPlayerName);
                        print(_playerList);
                        insertPlayerData(newTeamName, _newPlayerName, uid);
                        controllerPlayerName.clear();
                      },
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: Text('Done'),
                onPressed: () async {
                  getTeamSize(newTeamName,
                      uid); /*.then(
                    (value) {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .collection('teams')
                          .doc(newTeamName)
                          .update({"Players": _playerList});*/
                  //},
                  //);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(index: 1),
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
