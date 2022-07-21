import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class PullerWidget extends StatefulWidget {
  PullerWidget(
      {Key? key,
      required this.playerName,
      required this.playerStatus,
      required this.callbackFunction,
      required this.uid,
      required this.gameName})
      : super(key: key);
  var playerName;
  var playerStatus;
  var uid;
  var gameName;
  var callbackFunction;
  @override
  State<PullerWidget> createState() => _PullerWidgetState(
      playerName: this.playerName,
      playerStatus: this.playerStatus,
      callbackFunction: this.callbackFunction,
      uid: this.uid,
      gameName: this.gameName);
}

class _PullerWidgetState extends State<PullerWidget> {
  _PullerWidgetState(
      {required this.playerName,
      required this.playerStatus,
      required this.callbackFunction,
      required this.uid,
      required this.gameName});
  var playerName;
  var playerStatus;
  var uid;
  var gameName;
  var callbackFunction;
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
                padding: EdgeInsets.fromLTRB(0, 9, 0, 0),
                child: Container(
                  child: ButtonBar(children: [
                    ButtonTheme(
                      child: ElevatedButton(
                        child: Text("In Bounds"),
                        onPressed: () {
                          playersInstance.doc(playerName).update(
                              {"Number of Pulls": FieldValue.increment(1)});
                          callbackFunction(playerName, 4, 4);
                        },
                      ),
                    ),
                    ButtonTheme(
                      child: ElevatedButton(
                        child: Text("Out Bounds"),
                        onPressed: () {
                          playersInstance.doc(playerName).update({
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
