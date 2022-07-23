// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DefenseStartingWidget extends StatefulWidget {
  var playerName;
  var playerStatus;
  var uid;
  var gameName;
  final Function callbackFunction;
  DefenseStartingWidget(
      {Key? key,
      required this.playerName,
      required this.playerStatus,
      required this.callbackFunction,
      required this.uid,
      required this.gameName})
      : super(key: key);
  @override
  State<DefenseStartingWidget> createState() => _DefenseStartingWidgetState(
      playerName: playerName,
      playerStatus: playerStatus,
      callbackFunction: callbackFunction,
      uid: uid,
      gameName: gameName);
}

class _DefenseStartingWidgetState extends State<DefenseStartingWidget> {
  _DefenseStartingWidgetState(
      {required this.playerName,
      required this.playerStatus,
      required this.callbackFunction,
      required this.uid,
      required this.gameName});
  var playerName;
  var playerStatus;
  var uid;
  var gameName;
  final Function callbackFunction;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
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
                        child: const Text("Starting Puller"),
                        onPressed: () {
                          /*playersInstance.doc(playerName).update(
                              {"Number of Pulls": FieldValue.increment(1)});*/
                          callbackFunction(playerName, 5, 6);
                        }, /*() {
                          setState(() {
                            playerStatus.keys.forEach((k) {
                              if (k == playerName) {
                                playerStatus[playerName] = status[2];
                                print(playerStatus);
                              } else {
                                playerStatus[k] = status[1];
                                print(playerStatus);
                              }
                            });
                          });
                        },*/
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
