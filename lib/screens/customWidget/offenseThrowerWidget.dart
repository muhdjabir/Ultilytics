// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ThrowerOffWidget extends StatefulWidget {
  var playerName;
  var playerStatus;
  String myTeam;
  String uid;
  String gameName;
  final Function callbackFunction;
  ThrowerOffWidget(
      {Key? key,
      required this.playerName,
      required this.playerStatus,
      required this.gameName,
      required this.uid,
      required this.myTeam,
      required this.callbackFunction})
      : super(key: key);
  @override
  State<ThrowerOffWidget> createState() => _ThrowerOffWidgetState(
      playerName: playerName,
      playerStatus: playerStatus,
      gameName: gameName,
      myTeam: myTeam,
      uid: uid,
      callbackFunction: callbackFunction);
}

class _ThrowerOffWidgetState extends State<ThrowerOffWidget> {
  _ThrowerOffWidgetState(
      {required this.playerName,
      required this.playerStatus,
      required this.myTeam,
      required this.callbackFunction,
      required this.gameName,
      required this.uid});
  var playerName;
  var playerStatus;
  String gameName;
  String uid;
  String myTeam;
  final Function callbackFunction;
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
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ButtonBar(children: [
                  ButtonTheme(
                    child: ElevatedButton(
                        child: const Text("Throwaway"),
                        onPressed: () {
                          playersInstance.doc(playerName).update({
                            "Throwaways": FieldValue.increment(1),
                            "Plus-Minus": FieldValue.increment(-1)
                          });
                          teamInstance.doc(playerName).update({
                            "Throwaways": FieldValue.increment(1),
                            "Plus-Minus": FieldValue.increment(-1)
                          });
                          callbackFunction(playerName, 4, 4);
                        } //4 = 'playerDef'
                        ),
                  ),
                  ButtonTheme(
                    child: ElevatedButton(
                        child: const Text("Stallout"),
                        onPressed: () {
                          playersInstance.doc(playerName).update({
                            "Stalled Out": FieldValue.increment(1),
                            "Plus-Minus": FieldValue.increment(-1)
                          });
                          teamInstance.doc(playerName).update({
                            "Stalled Out": FieldValue.increment(1),
                            "Plus-Minus": FieldValue.increment(-1)
                          });
                          callbackFunction(playerName, 4, 4);
                        } //4 = 'playerDef'
                        ),
                  ),
                ])),
          ],
        ),
      ),
    );
  }
}
