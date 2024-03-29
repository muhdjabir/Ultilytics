// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/screens/NavigationBarScreen.dart';
import '../GameEntries/NewLineScreen.dart';

class ReceiverOffWidget extends StatefulWidget {
  var playerName;
  var playerStatus;
  String gameName;
  String uid;
  var myScore;
  var opponentScore;
  String myTeam;
  String opponentTeam;
  Duration timeLeft;
  bool isPlaying;
  var thrower;
  final Function callbackFunction;
  ReceiverOffWidget({
    Key? key,
    required this.playerName,
    required this.playerStatus,
    required this.callbackFunction,
    required this.gameName,
    required this.uid,
    required this.myScore,
    required this.opponentScore,
    required this.myTeam,
    required this.opponentTeam,
    required this.timeLeft,
    required this.isPlaying,
  }) : super(key: key);
  @override
  State<ReceiverOffWidget> createState() => _ReceiverOffWidgetState(
        playerName: playerName,
        playerStatus: playerStatus,
        callbackFunction: callbackFunction,
        gameName: gameName,
        uid: uid,
        myScore: myScore,
        opponentScore: opponentScore,
        myTeam: myTeam,
        opponentTeam: opponentTeam,
        timeLeft: timeLeft,
        isPlaying: isPlaying,
      );
}

class _ReceiverOffWidgetState extends State<ReceiverOffWidget> {
  _ReceiverOffWidgetState({
    required this.playerName,
    required this.playerStatus,
    required this.callbackFunction,
    required this.gameName,
    required this.uid,
    required this.myScore,
    required this.opponentScore,
    required this.myTeam,
    required this.opponentTeam,
    required this.timeLeft,
    required this.isPlaying,
  });
  var playerName;
  var playerStatus;
  String gameName;
  String uid;
  var myScore;
  var opponentScore;
  String myTeam;
  String opponentTeam;
  Duration timeLeft;
  final Function callbackFunction;
  bool isPlaying;
  num numPlayers = 0;
  //final stopwatch = Stopwatch();

  Future<void> getNumPlayers(final uid, final gameName) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('games')
        .doc(gameName)
        .collection('players')
        .get()
        .then((value) => (numPlayers = value.docs.length));
  }

  Future<String> getThrower(final playerStatus, String thrower) async {
    for (var player in playerStatus.keys) {
      if (playerStatus[player] == 'throwerOff') {
        return thrower = player.toString();
      }
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    getNumPlayers(uid, gameName);
    var playersInstance = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('games')
        .doc(gameName)
        .collection('players');
    var gameInstance = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('games')
        .doc(gameName);
    var teamInstance = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('teams')
        .doc(myTeam)
        .collection('players');
    var teamRecord = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('teams')
        .doc(myTeam);
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 10, 52, 87),
            ),
            child: Row(
              children: [
                Container(
                  width: 68,
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(playerName,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.deepPurpleAccent,
                      )),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Container(
                        child: ButtonBar(children: [
                      ButtonTheme(
                        child: ElevatedButton(
                            child: const Text("+Catch"),
                            onPressed: () {
                              //var thrower = getThrower.toString();
                              //print(thrower);
                              String thrower = '';
                              getThrower(playerStatus, thrower).then(
                                (thrower) {
                                  playersInstance.doc(thrower).update({
                                    "Advantageous Throw":
                                        FieldValue.increment(1),
                                    "Total Throws": FieldValue.increment(1)
                                  });
                                  teamInstance.doc(thrower).update({
                                    "Advantageous Throw":
                                        FieldValue.increment(1),
                                    "Total Throws": FieldValue.increment(1)
                                  });
                                },
                              );
                              playersInstance.doc(playerName).update({
                                "Catch": FieldValue.increment(1),
                                "Touches": FieldValue.increment(1)
                              });
                              teamInstance.doc(playerName).update({
                                "Catch": FieldValue.increment(1),
                                "Touches": FieldValue.increment(1)
                              });
                              callbackFunction(playerName, 2, 1);
                            } //2 = 'receiverOff', 1 = 'startingOff'
                            ),
                      ),
                      ButtonTheme(
                        child: ElevatedButton(
                            child: const Text("-Catch"),
                            onPressed: () {
                              String thrower = '';
                              getThrower(playerStatus, thrower).then(
                                (thrower) {
                                  //print(thrower);
                                  playersInstance.doc(thrower).update({
                                    "Total Throws": FieldValue.increment(1),
                                  });
                                  teamInstance.doc(thrower).update({
                                    "Total Throws": FieldValue.increment(1),
                                  });
                                },
                              );
                              playersInstance.doc(playerName).update({
                                "Catch": FieldValue.increment(1),
                                "Touches": FieldValue.increment(1)
                              });
                              teamInstance.doc(playerName).update({
                                "Catch": FieldValue.increment(1),
                                "Touches": FieldValue.increment(1)
                              });
                              callbackFunction(playerName, 2, 1);
                            } //2 = 'receiverOff', 1 = 'startingOff'
                            ),
                      ),
                      ButtonTheme(
                        child: ElevatedButton(
                            child: const Text("Drop"),
                            onPressed: () {
                              playersInstance.doc(playerName).update({
                                "Drops": FieldValue.increment(1),
                                "Plus-Minus": FieldValue.increment(-1)
                              });
                              teamInstance.doc(playerName).update({
                                "Drops": FieldValue.increment(1),
                                "Plus-Minus": FieldValue.increment(-1)
                              });
                              callbackFunction(playerName, 4, 4);
                            } // 4 = 'playerDef'
                            ),
                      ),
                      ButtonTheme(
                        child: ElevatedButton(
                            child: const Text("Score"),
                            onPressed: () {
                              String thrower = '';
                              getThrower(playerStatus, thrower).then(
                                (thrower) {
                                  playersInstance.doc(thrower).update({
                                    "Assists": FieldValue.increment(1),
                                    "Plus-Minus": FieldValue.increment(1),
                                    "Total Throws": FieldValue.increment(1),
                                    "Advantageous Throw":
                                        FieldValue.increment(1)
                                  });
                                  teamInstance.doc(thrower).update({
                                    "Assists": FieldValue.increment(1),
                                    "Plus-Minus": FieldValue.increment(1),
                                    "Total Throws": FieldValue.increment(1),
                                    "Advantageous Throw":
                                        FieldValue.increment(1)
                                  });
                                },
                              );
                              //var thrower = getThrower(playerStatus).toString();
                              playersInstance.doc(playerName).update({
                                "Goals Scored": FieldValue.increment(1),
                                "Plus-Minus": FieldValue.increment(1),
                                "Touches": FieldValue.increment(1)
                              });
                              teamInstance.doc(playerName).update({
                                "Goals Scored": FieldValue.increment(1),
                                "Plus-Minus": FieldValue.increment(1),
                                "Touches": FieldValue.increment(1)
                              });
                              gameInstance.update(
                                  {"My Score": FieldValue.increment(1)});
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                          content: const Text(
                                              'Are you starting the next point on Offense or Defense?'),
                                          actions: [
                                            TextButton(
                                                child: const Text('Game Over'),
                                                onPressed: () {
                                                  myScore += 1;

                                                  if (opponentScore > myScore) {
                                                    teamRecord.update({
                                                      "Loses":
                                                          FieldValue.increment(
                                                              1)
                                                    });
                                                    print("We lose");
                                                  } else if (myScore >
                                                      opponentScore) {
                                                    teamRecord.update({
                                                      "Wins":
                                                          FieldValue.increment(
                                                              1)
                                                    });
                                                    print("we win");
                                                  } else {
                                                    teamRecord.update({
                                                      "Draws":
                                                          FieldValue.increment(
                                                              1)
                                                    });
                                                    print("everyone wins");
                                                  }
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const NavigationBarScreen(
                                                                index: 0)),
                                                  );
                                                }),
                                            const SizedBox(width: 50),
                                            TextButton(
                                                child: const Text('Offense'),
                                                onPressed: () {
                                                  myScore += 1;
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              NewLineScreen(
                                                                gameName:
                                                                    gameName,
                                                                uid: uid,
                                                                newPointState:
                                                                    'Offense',
                                                                numPlayers:
                                                                    numPlayers,
                                                                myScore:
                                                                    myScore,
                                                                myTeam: myTeam,
                                                                opponentScore:
                                                                    opponentScore,
                                                                opponentTeam:
                                                                    opponentTeam,
                                                                timeLeft:
                                                                    timeLeft,
                                                                isPlaying:
                                                                    isPlaying,
                                                              )));
                                                }),
                                            TextButton(
                                                child: const Text('Defense'),
                                                onPressed: () {
                                                  myScore += 1;
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              NewLineScreen(
                                                                  gameName:
                                                                      gameName,
                                                                  uid: uid,
                                                                  newPointState:
                                                                      'Defense',
                                                                  numPlayers:
                                                                      numPlayers,
                                                                  myScore:
                                                                      myScore,
                                                                  myTeam:
                                                                      myTeam,
                                                                  opponentScore:
                                                                      opponentScore,
                                                                  opponentTeam:
                                                                      opponentTeam,
                                                                  timeLeft:
                                                                      timeLeft,
                                                                  isPlaying:
                                                                      isPlaying)));
                                                })
                                          ]));
                            }),
                      )
                    ]))),
              ],
            )));
  }
}
