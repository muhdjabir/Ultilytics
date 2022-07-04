//team select
//game details date
//time start
//opponent name
//tournament name
//comments weather/wind...
//starting on O or D
//type of game
//lineup page

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
//import 'package:orbital_ultylitics/screens/NewLineScreen.dart';
import 'package:orbital_ultylitics/screens/newLineScreen.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({Key? key}) : super(key: key);

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

var numPlayers = 0;
Future<void> insertPlayerData(
    final gameName, final newPlayerName, final uid) async {
  CollectionReference usersCollectionRef =
      FirebaseFirestore.instance.collection('users');
  /*usersCollectionRef.doc(uid).collection('teams').doc(newTeamName).set({
    //"Players": FieldValue.arrayUnion([newPlayerName])
    //"Number of Players": FieldValue.increment(1),
  }, SetOptions(merge: true));*/
  usersCollectionRef
      .doc(uid)
      .collection('games')
      .doc(gameName)
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
    "Drops": 0,
    "Plus-Minus": 0,
    "Stalled Out": 0,
  });
}

Future<void> getNumPlayers(final uid, final myTeam) async {
  //var numPlayers;
  numPlayers = 0;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('teams')
      .doc(myTeam)
      .collection('players')
      .get()
      .then((snapshot) => (snapshot.docs.forEach((document) {
            numPlayers += 1;
          })));
  //numPlayers = myPlayers.length;
}

Future<void> createGameData(
    final uid,
    final gameName,
    final myTeam,
    final opponentTeam,
    final offDefState,
    final gameDetails,
    final gameType) async {
  CollectionReference usersCollectionRef =
      FirebaseFirestore.instance.collection('users');
  usersCollectionRef.doc(uid).collection('games').doc(gameName).set({
    "My Score": 0,
    "Opponent Score": 0,
    "My Team": myTeam,
    "Opponents": opponentTeam,
    "Start O or D": offDefState,
    "Game Details": gameDetails,
    "Game Type": gameType
  });
  /*usersCollectionRef.doc(uid).collection('teams').doc(myTeam).set({
    "Teams": FieldValue.arrayUnion([newTeamName]), "My Score": 0, "Opponent Score": 0 
  }, SetOptions(merge: true));*/
  List<String> myPlayers = [];
  // = getPlayerNames(uid, myTeam, myPlayers);
  Future getPlayerNames(final uid, final myTeam) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('teams')
        .doc(myTeam)
        .collection('players')
        .get()
        .then((snapshot) => (snapshot.docs.forEach((document) {
              myPlayers.add(document.reference.id);
            })));
    //numPlayers = myPlayers.length;
  }

  getPlayerNames(uid, myTeam).then((value) {
    for (int i = 0; i < myPlayers.length; i += 1) {
      //print(myPlayers[i]);
      insertPlayerData(gameName, myPlayers[i], uid);
    }
  });
}

// ignore: camel_case_types
class _NewGameScreenState extends State<NewGameScreen> {
  //final Globalkey<FormState> _formkeyValue=new
  late TextEditingController controllerOpponentName;
  String _opponentName = "";
  late TextEditingController controllerTournamentName;
  String _gameDetails = "";
  late TextEditingController controllerGameDetails;
  late TextEditingController controllerGameName;
  String _gameName = "";
  //late List<DropdownMenuItem<String>>? offenseDefenceSelect = ['Offense', 'Defence'];
  //var me = FirebaseFirestore.instance.collection('users').doc(uid);
  late var myTeams;
  String? myTeamSelect;
  String? myStartState;
  var durationHours;
  var durationMins;
  var durationSecs;
  String? myGameType;

  @override
  void initState() {
    super.initState();
    controllerOpponentName = TextEditingController();
    controllerTournamentName = TextEditingController();
    controllerGameDetails = TextEditingController();
    controllerGameName = TextEditingController();
    _opponentName = PageStorage.of(context)
            ?.readState(context, identifier: ValueKey("storeOpponentName")) ??
        "";
  }

  /*Future getTeamDocs(String uid) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(uid)
        .collection('teams')
        .get();
    setState(() {
      myTeams =
          List.from(querySnapshot.docs.map((doc) => doc.data()['Team Name']));
    });
  }*/

  final FirebaseAuth auth = FirebaseAuth.instance;
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(color: Colors.grey),
        ),
      );
  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user!.uid;

    //late var myTeams;
    //var teamsData = getTeamDocs(uid);
    /*(value) {
      setState(() {
        List<String> myTeams= List.from(value.data['Teams']);
      });
    });*/
    //late var myTeams = FirebaseFirestore.instance.collection('users');
    /*var teamsSnapshot = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('teams')
        .snapshots();*/
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Container(
            alignment: Alignment.centerLeft,
            child: const Text("Create New Game")),
      ),
      //elevation: 0,
      body: //Form(
          //key:_formkeyValue,
          //autovalidateMode:true,
          //child:
          ListView(
        key: PageStorageKey<String>('NewGameScreen'),
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        children: <Widget>[
          Container(height: 15),
          TextFormField(
            cursorColor: Colors.grey,
            controller: controllerGameName,
            style: const TextStyle(color: Color.fromARGB(255, 52, 145, 33)),
            decoration: InputDecoration(
              icon: const Icon(
                Icons.play_circle_outline_sharp,
                color: Color.fromARGB(255, 52, 145, 33),
                size: 40,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.blue),
                borderRadius: BorderRadius.circular(15),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              fillColor: const Color.fromRGBO(66, 165, 245, 1.0),
              hintText: "Enter Game Name",
              hintStyle: TextStyle(color: Color.fromARGB(255, 75, 75, 75)),
              labelText: "Game Name:",
              labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            onChanged: (val) {
              setState(() {
                _gameName = val;
              });
            },
          ),
          Row(
            children: [
              const Icon(
                Icons.group_sharp,
                color: Color.fromARGB(255, 46, 119, 179),
                size: 40,
              ),
              SizedBox(width: 17),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .collection('teams')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<DropdownMenuItem> teamItems = [];
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      DocumentSnapshot snap = snapshot.data!.docs[i];
                      //print(snap.id);
                      teamItems.add(DropdownMenuItem(
                          child: Text(snap.id), value: snap.id));
                    }
                    if (teamItems == null) {
                      return const Text("Go and create a Team!!",
                          style: TextStyle(color: Colors.amber));
                    } else {
                      return DropdownButton<dynamic>(
                        value: myTeamSelect,
                        hint: const Text(
                          "Select Your Team",
                          style: TextStyle(color: Color.fromARGB(255, 46, 119, 179), fontSize: 20),
                        ),
                        //isExpanded: true,
                        style: const TextStyle(color: Color.fromARGB(255, 46, 119, 179)),
                        items: teamItems,
                        onChanged: (myTeamSelect) => setState(() {
                          this.myTeamSelect = myTeamSelect;
                          getNumPlayers(uid, myTeamSelect);
                        }),
                      );
                    }
                  } else {
                    return const Text("something is wrong",
                        style: TextStyle(color: Colors.amber));
                  }
                },
              )),
            ],
          ),
          //opponents name
          TextFormField(
            cursorColor: Colors.grey,
            controller: controllerOpponentName,
            style: const TextStyle(color: Color.fromARGB(255, 172, 56, 48)),
            decoration: InputDecoration(
              icon: const Icon(
                Icons.group_sharp,
                color: Color.fromARGB(255, 172, 56, 48),
                size: 40,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.blue),
                borderRadius: BorderRadius.circular(15),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              fillColor: const Color.fromRGBO(66, 165, 245, 1.0),
              hintText: "Enter Opponents Name",
              hintStyle: TextStyle(color: Color.fromARGB(255, 75, 75, 75)),
              labelText: "Opponents:",
              labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            onChanged: (val) {
              setState(() {
                _opponentName = val;
                PageStorage.of(context)?.writeState(context, _opponentName,
                    identifier: ValueKey("storeOpponentName"));
              });
            },
          ),
          Row(
            children: [
              Transform.rotate(
                angle: 90 * 3.141 / 180,
                child: const Icon(
                  Icons
                      .compare_arrows, //flip_camera_android,//run_circle_outlined,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                flex: 1,
                child: DropdownButton<String>(
                    hint: const Text(
                      "Start O or D",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    //isExpanded: true,
                    style: const TextStyle(color: Colors.white),
                    items: [
                      _dropdownItem("Offense"),
                      _dropdownItem("Defense"),
                    ],
                    value: myStartState,
                    onChanged: (myStartState) =>
                        setState(() => this.myStartState = myStartState)),
              ),
              Expanded(
                flex: 1,
                child: DropdownButton<String>(
                    hint: const Text(
                      "Game Type",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    //isExpanded: true,
                    style: const TextStyle(color: Colors.white),
                    items: [
                      _dropdownItem("Friendly"),
                      _dropdownItem("Group Stages"),
                      _dropdownItem("Seeding"),
                      _dropdownItem("Quarter-finals"),
                      _dropdownItem("Semi-finals"),
                      _dropdownItem("Finals"),
                      _dropdownItem("Others"),
                    ],
                    value: myGameType,
                    onChanged: (myGameType) =>
                        setState(() => this.myGameType = myGameType)),
              )
            ],
          ),
          Container(
            height: 15,
          ),
          Row(
            children: [
              const Icon(
                Icons
                    .timer_outlined, //flip_camera_android,//run_circle_outlined,
                color: Colors.grey,
                size: 40,
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 1,
                child: DropdownButton<String>(
                    hint: const Text(
                      "Hours",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    //isExpanded: true,
                    style: const TextStyle(color: Colors.white),
                    items: [
                      _dropdownItem('0'),
                      _dropdownItem('1'),
                      _dropdownItem('2'),
                    ],
                    value: durationHours,
                    onChanged: (durationHours) =>
                        setState(() => this.durationHours = durationHours)),
              ),
              Expanded(
                flex: 1,
                child: DropdownButton<String>(
                    hint: const Text(
                      "Minutes",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    //isExpanded: true,
                    style: const TextStyle(color: Colors.white),
                    items: [
                      _dropdownItem("0"),
                      _dropdownItem("5"),
                      _dropdownItem("10"),
                      _dropdownItem("15"),
                      _dropdownItem("20"),
                      _dropdownItem("25"),
                      _dropdownItem("30"),
                      _dropdownItem("35"),
                      _dropdownItem("40"),
                      _dropdownItem("45"),
                      _dropdownItem("50"),
                      _dropdownItem("55"),
                    ],
                    value: durationMins,
                    onChanged: (durationMins) =>
                        setState(() => this.durationMins = durationMins)),
              )
            ],
          ),
          Container(
            height: 15,
          ),
          //game details/comments box
          TextFormField(
            minLines: 2,
            maxLines: 7,
            keyboardType: TextInputType.multiline,
            cursorColor: Colors.grey,
            controller: controllerGameDetails,
            style: const TextStyle(color: Colors.limeAccent),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.blue),
                borderRadius: BorderRadius.circular(15),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              icon: const Icon(
                Icons.format_list_bulleted_sharp,
                color: Colors.grey,
                size: 40,
              ),
              fillColor: const Color.fromRGBO(66, 165, 245, 1.0),
              hintText:
                  "Enter any game details (eg current weather, field conditions, wind direction)",
              hintStyle: TextStyle(color: Color.fromARGB(255, 75, 75, 75)),
              labelText: "Comments:",
              labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            onChanged: (val) {
              setState(() {
                _gameDetails = val;
              });
            },
          ),
          ElevatedButton(
            child: const Text('Create Game'),
            onPressed: () async {
              //print(_opponentName);
              //print(teamItems);
              //print(myTeamSelect);

//INCLUDE THE BELOW 2 LINES TO SAVE GAME DATA
              createGameData(uid, _gameName, myTeamSelect, _opponentName,
                  myStartState, _gameDetails, myGameType);
              //numPlayers = snapshot.data!.docs.length;
              print("i have $numPlayers many players in the newgamescreen");
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewLineScreen(
                    gameName: _gameName,
                    numPlayers: numPlayers,
                    uid: uid,
                    newPointState: myStartState,
                    myScore: 0,
                    myTeam: myTeamSelect,
                    opponentScore: 0,
                    opponentTeam: _opponentName,
                    timeLeft: Duration(
                        hours: int.parse(durationHours),
                        minutes: int.parse(durationMins),
                        seconds: 0),
                    isPlaying: false,
                  ),
                ),
              );

              /*insertTeamData(newTeamName, uid, _playerList.length);
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .collection('teams')
                      .doc(newTeamName)
                      .update({"Players": _playerList});
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(index: 3),
                    ),
                  );*/
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return Colors.blue;
              }),
            ),
          ),
        ],
      ), //),
    );
  }
}

_dropdownItem(String item) {
  return DropdownMenuItem<String>(
      value: item,
      child: Text(item, style: const TextStyle(color: Colors.grey)));
}
/*{
DropdownButton(
  //isExpanded : true
  items: items.map((itemsname){
    value:itemsname,
    child: Text(itemsname)
    onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
  })
)}*/
