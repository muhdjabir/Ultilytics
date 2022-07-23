import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

var status = [
  'startingOff',
  'receiverOff',
  'throwerOff',
  'startingDef',
  'playerDef'
];

class OffenseStartingWidget extends StatefulWidget {
  var playerName;
  var playerStatus;
  String myTeam;
  String uid;
  String gameName;
  final Function callbackFunction;
  OffenseStartingWidget(
      {Key? key,
      required this.playerName,
      required this.playerStatus,
      required this.gameName,
      required this.uid,
      required this.myTeam,
      required this.callbackFunction})
      : super(key: key);
  @override
  State<OffenseStartingWidget> createState() => _OffenseStartingWidgetState(
      playerName: playerName,
      playerStatus: playerStatus,
      gameName: gameName,
      myTeam: myTeam,
      uid: uid,
      callbackFunction: callbackFunction);
}

class _OffenseStartingWidgetState extends State<OffenseStartingWidget> {
  _OffenseStartingWidgetState(
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
                child: Container(
                  child: ButtonBar(children: [
                    ButtonTheme(
                      child: ElevatedButton(
                        child: const Text("Starting Thrower"),
                        onPressed: () {
                          playersInstance.doc(playerName).update({
                            "Touches": FieldValue.increment(1),
                          });
                          teamInstance.doc(playerName).update({
                            "Touches": FieldValue.increment(1),
                          });
                          callbackFunction(playerName, 2, 1);
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
