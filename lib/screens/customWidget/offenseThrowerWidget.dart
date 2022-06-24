import 'package:flutter/material.dart';

var status = [
  'startingOff',
  'receiverOff',
  'throwerOff',
  'startingDef',
  'playerDef'
];

class ThrowerOffWidget extends StatefulWidget {
  var playerName;
  var playerStatus;
  ThrowerOffWidget(
      {Key? key, required this.playerName, required this.playerStatus})
      : super(key: key);
  @override
  State<ThrowerOffWidget> createState() => _ThrowerOffWidgetState(
      playerName: this.playerName, playerStatus: this.playerStatus);
}

class _ThrowerOffWidgetState extends State<ThrowerOffWidget> {
  _ThrowerOffWidgetState(
      {required this.playerName, required this.playerStatus});
  var playerName;
  var playerStatus;
  @override
  Widget build(BuildContext context) {
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
                        child: Text("Throwaway"),
                        onPressed: () {
                          setState(() {
                            playerStatus.keys.forEach((k) {
                              if (k == playerName) {
                                playerStatus[playerName] = status[4]; //defender
                                print(playerStatus);
                              } else {
                                playerStatus[k] = status[4]; //defender
                                //print(playerStatus);
                              }
                            });
                          });
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
