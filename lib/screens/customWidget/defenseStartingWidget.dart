import 'package:flutter/material.dart';

class defenseStartingWidget extends StatefulWidget {
  var playerName;
  var playerStatus;
  final Function callbackFunction;
  defenseStartingWidget(
      {Key? key,
      required this.playerName,
      required this.playerStatus,
      required this.callbackFunction})
      : super(key: key);
  @override
  State<defenseStartingWidget> createState() => _defenseStartingWidgetState(
      playerName: this.playerName,
      playerStatus: this.playerStatus,
      callbackFunction: this.callbackFunction);
}

class _defenseStartingWidgetState extends State<defenseStartingWidget> {
  _defenseStartingWidgetState(
      {required this.playerName,
      required this.playerStatus,
      required this.callbackFunction});
  var playerName;
  var playerStatus;
  final Function callbackFunction;
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
                        child: Text("Starting Puller"),
                        onPressed: () => callbackFunction(playerName, 4,
                            4), /*() {
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