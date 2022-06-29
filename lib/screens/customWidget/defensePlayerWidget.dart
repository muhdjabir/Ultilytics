import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../newLineScreen.dart';

double? gapWidth = 0;

class defPlayerWidget extends StatefulWidget {
  var playerName;
  var playerStatus;
  String gameName;
  String uid;

  final Function callbackFunction;
  defPlayerWidget({
    Key? key,
    required this.playerName,
    required this.playerStatus,
    required this.callbackFunction,
    required this.gameName,
    required this.uid,
  }) : super(key: key);
  @override
  State<defPlayerWidget> createState() => _defPlayerWidgetState(
        playerName: this.playerName,
        playerStatus: this.playerStatus,
        callbackFunction: this.callbackFunction,
        gameName: this.gameName,
        uid: this.uid,
      );
}

class _defPlayerWidgetState extends State<defPlayerWidget> {
  _defPlayerWidgetState({
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
                        onPressed: () => callbackFunction(playerName, 2, 1),
                      ),
                    ),
                    Container(
                      width: gapWidth,
                    ),
                    ButtonTheme(
                      child: ElevatedButton(
                        child: const Text("Block"),
                        onPressed: () => callbackFunction(playerName, 0, 0),
                      ),
                    ),
                    Container(
                      width: gapWidth,
                    ),
                    ButtonTheme(
                      child: ElevatedButton(
                          child: const Text("Scored on"),
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
                                                            gameName: gameName,
                                                            uid: uid,
                                                            newPointState:
                                                                'Offense',
                                                            numPlayers:
                                                                numPlayers,
                                                          )),
                                                )),
                                        TextButton(
                                            child: Text('Defense'),
                                            onPressed: () => Navigator.push(
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
                                                          )),
                                                ))
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
