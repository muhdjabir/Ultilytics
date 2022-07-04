import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../newLineScreen.dart';

var status = [
  'startingOff',
  'receiverOff',
  'throwerOff',
  'startingDef',
  'playerDef'
];

class ReceiverOffWidget extends StatefulWidget {
  var playerName;
  var playerStatus;
  String gameName;
  String uid;
  final Function callbackFunction;
  ReceiverOffWidget({
    Key? key,
    required this.playerName,
    required this.playerStatus,
    required this.callbackFunction,
    required this.gameName,
    required this.uid,
  }) : super(key: key);
  @override
  State<ReceiverOffWidget> createState() => _ReceiverOffWidgetState(
        playerName: playerName,
        playerStatus: playerStatus,
        callbackFunction: callbackFunction,
        gameName: gameName,
        uid: uid,
      );
}

class _ReceiverOffWidgetState extends State<ReceiverOffWidget> {
  _ReceiverOffWidgetState({
    required this.playerName,
    required this.playerStatus,
    required this.callbackFunction,
    required this.gameName,
    required this.uid,
  });
  var playerName;
  var playerStatus;
  String gameName;
  String uid;
  final Function callbackFunction;
  num numPlayers = 0;

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

  @override
  Widget build(BuildContext context) {
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
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Container(
                        child: ButtonBar(children: [
                      ButtonTheme(
                        child: ElevatedButton(
                          child: Text("Catch"),
                          onPressed: () => callbackFunction(playerName, 2,
                              1), //2 = 'receiverOff', 1 = 'startingOff'
                        ),
                      ),
                      ButtonTheme(
                        child: ElevatedButton(
                          child: Text("Drop"),
                          onPressed: () => callbackFunction(
                              playerName, 4, 4), // 4 = 'playerDef'
                        ),
                      ),
                      ButtonTheme(
                        child: ElevatedButton(
                            child: Text("Score"),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                          content: Text(
                                              'Are you starting the next point on Offense or Defense?'),
                                          actions: [
                                            TextButton(
                                                child: Text('Offense'),
                                                onPressed: () => Navigator.push(
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
                                                            )))),
                                            TextButton(
                                                child: Text('Defense'),
                                                onPressed: () => Navigator.push(
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
                                                            ))))
                                          ]));
                            }),
                      )
                    ]))),
              ],
            )));
  }
}
