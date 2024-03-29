//team select
//game details date
//time start
//opponent name
//tournament name
//comments weather/wind...
//starting on O or D
//type of game
//lineup page

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/screens/GameEntries/NewLineScreen.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({Key? key}) : super(key: key);

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

var numPlayers = 0;
Future<void> insertPlayerData(
    final gameName, final newPlayerName, final uid) async {
  // Creates a new player collection in Firebase
  CollectionReference usersCollectionRef =
      FirebaseFirestore.instance.collection('users');
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
    // Creates a new game collection in Firebase
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
  List<String> myPlayers = [];
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

class _NewGameScreenState extends State<NewGameScreen> {
  late TextEditingController controllerOpponentName;
  String _opponentName = "";
  late TextEditingController controllerTournamentName;
  String _gameDetails = "";
  late TextEditingController controllerGameDetails;
  late TextEditingController controllerGameName;
  String _gameName = "";
  late var myTeams;
  String? myTeamSelect;
  String? myStartState;
  var durationHours;
  var durationMins;
  var durationSecs;
  String? myGameType;

  Future errorMessage(String error) => showDialog(
      context: context,
      builder: (context) => AlertDialog(title: Text('${error}'), actions: [
            TextButton(
              child: const Text('Okay'),
              onPressed: okay,
            )
          ]));

  void okay() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    controllerOpponentName = TextEditingController();
    controllerTournamentName = TextEditingController();
    controllerGameDetails = TextEditingController();
    controllerGameName = TextEditingController();
    _opponentName = PageStorage.of(context)?.readState(context,
            identifier: const ValueKey("storeOpponentName")) ??
        "";
  }

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Container(
            alignment: Alignment.centerLeft,
            child: const Text("Create New Game")),
      ),
      body: ListView(
        key: const PageStorageKey<String>('NewGameScreen'),
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
                borderSide: const BorderSide(width: 2, color: Colors.blue),
                borderRadius: BorderRadius.circular(15),
              ),
              border: const OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              fillColor: const Color.fromRGBO(66, 165, 245, 1.0),
              hintText: "Enter Game Name",
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 75, 75, 75)),
              labelText: "Game Name:",
              labelStyle: const TextStyle(color: Colors.grey, fontSize: 20),
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
              const SizedBox(width: 17),
              Expanded(
                  // Dropdown view of list of all teams in user account
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
                          style: TextStyle(
                              color: Color.fromARGB(255, 46, 119, 179),
                              fontSize: 20),
                        ),
                        //isExpanded: true,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 46, 119, 179)),
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
                borderSide: const BorderSide(width: 2, color: Colors.blue),
                borderRadius: BorderRadius.circular(15),
              ),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(const Radius.circular(15))),
              fillColor: const Color.fromRGBO(66, 165, 245, 1.0),
              hintText: "Enter Opponents Name",
              hintStyle:
                  const TextStyle(color: const Color.fromARGB(255, 75, 75, 75)),
              labelText: "Opponents:",
              labelStyle: const TextStyle(color: Colors.grey, fontSize: 20),
            ),
            onChanged: (val) {
              setState(() {
                _opponentName = val;
                PageStorage.of(context)?.writeState(context, _opponentName,
                    identifier: const ValueKey("storeOpponentName"));
              });
            },
          ),
          Row(
            children: [
              Transform.rotate(
                angle: 90 * 3.141 / 180,
                child: const Icon(
                  Icons.compare_arrows,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
              const SizedBox(width: 15),
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
                    // Choosing Game Type
                    hint: const Text(
                      "Game Stage",
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
                Icons.timer_outlined,
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
                borderSide: const BorderSide(width: 2, color: Colors.blue),
                borderRadius: BorderRadius.circular(15),
              ),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(const Radius.circular(15))),
              icon: const Icon(
                Icons.format_list_bulleted_sharp,
                color: Colors.grey,
                size: 40,
              ),
              fillColor: const Color.fromRGBO(66, 165, 245, 1.0),
              hintText:
                  "Enter any game details (eg current weather, field conditions, wind direction)",
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 75, 75, 75)),
              labelText: "Comments:",
              labelStyle: const TextStyle(color: Colors.grey, fontSize: 20),
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
              // Ensures the all data is provided before navigating to next widget
              if ((_gameName == null) ||
                  (numPlayers == null) ||
                  (myStartState == null) ||
                  (myTeamSelect == null) ||
                  (_opponentName == null) ||
                  (durationHours == null) ||
                  (durationMins == null)) {
                errorMessage("Please fill in all boxes");
              } else {
//INCLUDE THE BELOW 2 LINES TO SAVE GAME DATA
                createGameData(uid, _gameName, myTeamSelect, _opponentName,
                    myStartState, _gameDetails, myGameType);
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
              }
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
