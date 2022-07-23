import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/screens/HomePage.dart';
import 'package:orbital_ultylitics/screens/NavigationBarScreen.dart';

import '../newLineScreen.dart';

double? gapWidth = 0;

class DefPlayerWidget extends StatefulWidget {
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

  final Function callbackFunction;
  DefPlayerWidget(
      {Key? key,
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
      required this.isPlaying})
      : super(key: key);
  @override
  State<DefPlayerWidget> createState() => _DefPlayerWidgetState(
      playerName: this.playerName,
      playerStatus: this.playerStatus,
      callbackFunction: this.callbackFunction,
      gameName: this.gameName,
      uid: this.uid,
      myScore: this.myScore,
      opponentScore: this.opponentScore,
      myTeam: this.myTeam,
      opponentTeam: this.opponentTeam,
      timeLeft: this.timeLeft,
      isPlaying: this.isPlaying);
}

class _DefPlayerWidgetState extends State<DefPlayerWidget> {
  _DefPlayerWidgetState(
      {required this.playerName,
      required this.playerStatus,
      required this.callbackFunction,
      required this.gameName,
      required this.uid,
      required this.myScore,
      required this.opponentScore,
      required this.myTeam,
      required this.opponentTeam,
      required this.timeLeft,
      required this.isPlaying});
  var playerName;
  var playerStatus;
  String gameName;
  String uid;
  Duration timeLeft;
  var myScore;
  var opponentScore;
  String myTeam;
  String opponentTeam;
  bool isPlaying;

  final Function callbackFunction;
  var numPlayers;

  Future<void> getNumPlayers(final uid, final gameName) async {
    //var numPlayers;
    numPlayers = 0;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('games')
        .doc(gameName)
        .collection('players')
        .get()
        .then((value) => (numPlayers = value.docs.length));
  }

  @override
  Widget build(BuildContext context) {
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
    getNumPlayers(uid, gameName);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromARGB(255, 10, 52, 87),
        ),
        child: Row(
          children: [
            Container(
              width: 120,
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(playerName,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.deepPurpleAccent,
                  )),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 9, 0, 0),
                //child: Container(
                child: SingleChildScrollView(
                  //clipBehavior: Clip.hardEdge,
                  //physics: const ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    ButtonTheme(
                      //padding: EdgeInsets.all(8),
                      child: ElevatedButton(
                          child: const Text("Interception"),
                          onPressed: () {
                            playersInstance.doc(playerName).update({
                              "Interception": FieldValue.increment(1),
                              "Touches": FieldValue.increment(1),
                              "Plus-Minus": FieldValue.increment(1)
                            });
                            callbackFunction(playerName, 2, 1);
                          }),
                    ),
                    Container(
                      width: gapWidth,
                    ),
                    ButtonTheme(
                      child: ElevatedButton(
                          child: const Text("Block"),
                          onPressed: () {
                            playersInstance.doc(playerName).update({
                              "Interception": FieldValue.increment(1),
                              "Plus-Minus": FieldValue.increment(1)
                            });
                            callbackFunction(playerName, 0, 0);
                          }),
                    ),
                    Container(
                      width: gapWidth,
                    ),
                    ButtonTheme(
                      child: ElevatedButton(
                          child: const Text("Scored on"),
                          onPressed: () {
                            gameInstance.update(
                                {"Opponent Score": FieldValue.increment(1)});
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: Text(
                                          'Are you starting the next point on Offense or Defense?'),
                                      actions: [
                                        TextButton(
                                            child: Text('Game Over'),
                                            onPressed: () {
                                              opponentScore += 1;
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
                                            child: Text('Offense'),
                                            onPressed: () {
                                              opponentScore += 1;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        NewLineScreen(
                                                          gameName: gameName,
                                                          uid: uid,
                                                          newPointState:
                                                              'Offense',
                                                          numPlayers:
                                                              numPlayers,
                                                          myScore: myScore,
                                                          myTeam: myTeam,
                                                          opponentScore:
                                                              opponentScore,
                                                          opponentTeam:
                                                              opponentTeam,
                                                          timeLeft: timeLeft,
                                                          isPlaying: isPlaying,
                                                        )),
                                              );
                                            }),
                                        TextButton(
                                            child: Text('Defense'),
                                            onPressed: () {
                                              opponentScore += 1;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        NewLineScreen(
                                                          gameName: gameName,
                                                          uid: uid,
                                                          newPointState:
                                                              'Defense',
                                                          numPlayers:
                                                              numPlayers,
                                                          myScore: myScore,
                                                          myTeam: myTeam,
                                                          opponentScore:
                                                              opponentScore,
                                                          opponentTeam:
                                                              opponentTeam,
                                                          timeLeft: timeLeft,
                                                          isPlaying: isPlaying,
                                                        )),
                                              );
                                            })
                                      ],
                                    ));
                          }
                          //onPressed: () => callbackFunction(playerName, 6, 6),
                          ),
                    ),
                  ]),
                )),
          ],
        ),
      ),
    );
  }
}
