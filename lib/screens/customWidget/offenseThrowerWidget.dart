import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ThrowerOffWidget extends StatefulWidget {
  var playerName;
  var playerStatus;
  final Function callbackFunction;
  String gameName;
  String uid;
  ThrowerOffWidget({
    Key? key,
    required this.playerName,
    required this.playerStatus,
    required this.callbackFunction,
    required this.gameName,
    required this.uid,
  }) : super(key: key);
  @override
  State<ThrowerOffWidget> createState() => _ThrowerOffWidgetState(
      playerName: this.playerName,
      playerStatus: this.playerStatus,
      callbackFunction: this.callbackFunction,
      gameName: this.gameName,
      uid: this.uid);
}

class _ThrowerOffWidgetState extends State<ThrowerOffWidget> {
  _ThrowerOffWidgetState({
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
  
  @override
  Widget build(BuildContext context) {
    var playersInstance = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('games')
      .doc(gameName)
      .collection('players');
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
                child: ButtonBar(children: [
                  ButtonTheme(
                    child: ElevatedButton(
                      child: Text("Throwaway"),
                      onPressed: () {
                              playersInstance.doc(playerName).update({"Throwaways": FieldValue.increment(1),"Plus-Minus":FieldValue.increment(-1)});
                              callbackFunction(playerName, 4, 4);
                            } //4 = 'playerDef'
                    ),
                  ),
                  ButtonTheme(
                    child: ElevatedButton(
                      child: Text("Stallout"),
                      onPressed: () {
                              playersInstance.doc(playerName).update({"Stalled Out": FieldValue.increment(1),"Plus-Minus":FieldValue.increment(-1)});
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
