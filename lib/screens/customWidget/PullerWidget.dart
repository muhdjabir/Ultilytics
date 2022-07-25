// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PullerWidget extends StatefulWidget {
  PullerWidget(
      {Key? key,
      required this.playerName,
      required this.playerStatus,
      required this.callbackFunction,
      required this.uid,
      required this.gameName,
      required this.myTeam})
      : super(key: key);
  var playerName;
  var playerStatus;
  var uid;
  var gameName;
  var callbackFunction;
  String myTeam;
  @override
  State<PullerWidget> createState() => _PullerWidgetState(
      playerName: playerName,
      playerStatus: playerStatus,
      callbackFunction: callbackFunction,
      uid: uid,
      gameName: gameName,
      myTeam: myTeam);
}

class _PullerWidgetState extends State<PullerWidget> {
  _PullerWidgetState(
      {required this.playerName,
      required this.playerStatus,
      required this.callbackFunction,
      required this.uid,
      required this.gameName,
      required this.myTeam});
  var playerName;
  var playerStatus;
  var uid;
  var gameName;
  var callbackFunction;
  String myTeam;
  @override
  Widget build(BuildContext context) {
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
              width: 120,
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(playerName,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.deepPurpleAccent,
                  )),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 9, 0, 0),
                child: Container(
                  child: ButtonBar(children: [
                    ButtonTheme(
                      child: ElevatedButton(
                        child: const Text("In Bounds"),
                        onPressed: () {
                          playersInstance.doc(playerName).update(
                              {"Number of Pulls": FieldValue.increment(1)});
                          teamInstance.doc(playerName).update(
                              {"Number of Pulls": FieldValue.increment(1)});
                          callbackFunction(playerName, 4, 4);
                        },
                      ),
                    ),
                    ButtonTheme(
                      child: ElevatedButton(
                        child: const Text("Out Bounds"),
                        onPressed: () {
                          playersInstance.doc(playerName).update({
                            "Number of Pulls": FieldValue.increment(1),
                            "Out of Bounds Pull": FieldValue.increment(1)
                          });
                          teamInstance.doc(playerName).update({
                            "Number of Pulls": FieldValue.increment(1),
                            "Out of Bounds Pull": FieldValue.increment(1)
                          });
                          callbackFunction(playerName, 4, 4);
                        },
                      ),
                    )
                  ]),
                )),
          ],
        ),
      ),
    );
  }
}
