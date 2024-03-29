// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/screens/GameEntries/StatTrackingScreen.dart';
import 'package:orbital_ultylitics/screens/NavigationBarScreen.dart';
//import 'package:orbital_ultylitics/screens/StatTrackingScreen.dart';

import '../customWidget/RoundButtonTimerWidget.dart';

class NewLineScreen extends StatefulWidget {
  //List<String> myPlayers;
  String gameName;
  String uid;
  var newPointState;
  var numPlayers;
  var myScore;
  var opponentScore;
  var myTeam;
  Duration timeLeft;
  String opponentTeam;
  bool isPlaying;
  NewLineScreen(
      {Key? key,
      required this.gameName,
      required this.numPlayers,
      required this.uid,
      required this.newPointState,
      required this.myScore,
      required this.opponentScore,
      required this.myTeam,
      required this.opponentTeam,
      required this.timeLeft,
      required this.isPlaying})
      : super(key: key);

  @override
  State<NewLineScreen> createState() => _NewLineScreenState(
      numPlayers: numPlayers,
      uid: uid,
      gameName: gameName,
      newPointState: newPointState,
      myScore: myScore,
      opponentScore: opponentScore,
      myTeam: myTeam,
      opponentTeam: opponentTeam,
      timeLeft: timeLeft,
      isPlaying: isPlaying);
}

class _NewLineScreenState extends State<NewLineScreen>
    with TickerProviderStateMixin {
  var numPlayers;
  //bool? _isChecked = false;
  //List<String> myPlayers;
  String uid;
  String gameName;
  Duration timeLeft;
  var newPointState;
  var myScore;
  var opponentScore;
  String myTeam;
  String opponentTeam;
  bool isPlaying;
  late AnimationController controller;
  //Int numPlayers;
  List<bool> isChecked = [];
  var lineupList = [];
  Future<bool?> getData() async {
    //print('is checked has $numPlayers');
    for (var i = 0; i < numPlayers; i += 1) {
      isChecked.add(false);
    }
    return null;
  }

  String get countText {
    Duration count = controller.duration! * controller.value;
    return '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: timeLeft,
    );

    if (isPlaying == true) {
      controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
    } else {
      controller.stop();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> getLineupList(final uid, final gameName) async {
    var index = 0;
    lineupList = [];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('games')
        .doc(gameName)
        .collection('players')
        .get()
        .then((snapshot) => (snapshot.docs.forEach((document) {
              if (isChecked[index] == true) {
                lineupList.add(document.reference.id);
              }
              index += 1;
            })));
    //numPlayers = myPlayers.length;
  }

  int numSelected = 0;
  var numSelectedString = "0";
  Future<bool?> getNumSelected() async {
    numSelected = 0;
    for (var i = 0; i < numPlayers; i += 1) {
      if (isChecked[i] == true) {
        numSelected += 1;
      }
    }
    //print(numSelected);
  }

  @override
  _NewLineScreenState(
      {required this.gameName,
      required this.numPlayers,
      required this.uid,
      required this.newPointState,
      required this.myScore,
      required this.opponentScore,
      required this.myTeam,
      required this.opponentTeam,
      required this.timeLeft,
      required this.isPlaying});
  @override
  Widget build(BuildContext context) {
    getData();
    //print("$numPlayers number of players");
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      getNumSelected();
      numSelectedString = numSelected.toString();
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text(
                "$newPointState lineup: $numSelectedString players selected "),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(children: [
                  Row(children: [
                    AnimatedBuilder(
                        animation: controller,
                        builder: (context, child) => Text(countText,
                            style: const TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70))),
                    GestureDetector(
                        onTap: () {
                          if (controller.isAnimating) {
                            controller.stop();
                            setState(() {
                              isPlaying = false;
                            });
                          } else {
                            controller.reverse(
                                from: controller.value == 0
                                    ? 1.0
                                    : controller.value);
                            setState(() {
                              isPlaying = true;
                            });
                          }
                        },
                        child: RoundButton(
                          color: isPlaying == true
                              ? Colors.yellow[700]
                              : Colors.green[700],
                          icon: isPlaying == true
                              ? Icons.pause
                              : Icons.play_arrow,
                        ))
                  ]),
                  StreamBuilder<QuerySnapshot>(
                      // Creates List of the players available in team
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .collection('games')
                          .doc(gameName)
                          .collection('players')
                          .snapshots(),
                      //initialData: getData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          //print("snapshothasdata");
                          //print(uid);
                          return ListView.builder(
                              physics:
                                  const NeverScrollableScrollPhysics(), //AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: ((context, index) {
                                QueryDocumentSnapshot<Object?>?
                                    documentSnapshot =
                                    snapshot.data?.docs[index];
                                //print('index $index');
                                return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0),
                                    child: CheckboxListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        title: Text(
                                            (documentSnapshot != null)
                                                ? (documentSnapshot[
                                                    "Player Name"])
                                                : "",
                                            style: const TextStyle(
                                                color:
                                                    Colors.deepPurpleAccent)),
                                        value: isChecked[index],
                                        activeColor: Colors.orangeAccent,
                                        checkColor: Colors.limeAccent,
                                        tileColor: const Color.fromARGB(
                                            255, 10, 52, 87),
                                        onChanged: (bool? value) {
                                          if (value != null) {
                                            setState(() {
                                              //print(value);
                                              //print(isChecked[index]);
                                              isChecked[index] = value;
                                              //print(isChecked[index]); //}
                                            });
                                          }
                                        }));
                              }));
                        } else {
                          return const Text("something is wrong",
                              style: TextStyle(color: Colors.amber));
                        }
                      }),
                  ElevatedButton(
                    clipBehavior: Clip.none,
                    child: const Text('Done Selecting Lineup'),
                    onPressed: () async {
                      // Updates the Firebase Collections
                      var playersInstance = FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .collection('games')
                          .doc(gameName)
                          .collection('players');
                      var teamInstance = FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .collection('teams')
                          .doc(myTeam)
                          .collection('players');
                      getLineupList(uid, gameName).then((value) {
                        //print('$lineupList');
                        for (var player in lineupList) {
                          playersInstance.doc(player).update(
                              {"Points Played": FieldValue.increment(1)});
                          teamInstance.doc(player).update(
                              {"Points Played": FieldValue.increment(1)});
                        }
                      }).then((value) {
                        //print('building $lineupList');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StatTrackingScreen(
                              myPlayers: lineupList,
                              uid: uid,
                              gameName: gameName,
                              newPointState: newPointState,
                              opponentScore: opponentScore,
                              myScore: myScore,
                              myTeam: myTeam,
                              opponentTeam: opponentTeam,
                              timeLeft:
                                  controller.duration! * controller.value ==
                                          const Duration(
                                              hours: 0, minutes: 0, seconds: 0)
                                      ? timeLeft
                                      : controller.duration! * controller.value,
                              isPlaying: isPlaying,
                            ),
                          ),
                        );
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (Set<MaterialState> states) {
                        return Colors.blue;
                      }),
                    ),
                  ),
                ])),
          ));
    });
  }
}
