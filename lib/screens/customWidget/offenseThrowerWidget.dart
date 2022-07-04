// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

class ThrowerOffWidget extends StatefulWidget {
  var playerName;
  var playerStatus;
  final Function callbackFunction;
  ThrowerOffWidget(
      {Key? key,
      required this.playerName,
      required this.playerStatus,
      required this.callbackFunction})
      : super(key: key);
  @override
  State<ThrowerOffWidget> createState() => _ThrowerOffWidgetState(
      playerName: this.playerName,
      playerStatus: this.playerStatus,
      callbackFunction: this.callbackFunction);
}

class _ThrowerOffWidgetState extends State<ThrowerOffWidget> {
  _ThrowerOffWidgetState(
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
                      onPressed: () =>
                          callbackFunction(playerName, 4, 4), //4 = 'playerDef'
                    ),
                  ),
                  ButtonTheme(
                    child: ElevatedButton(
                      child: const Text("Stallout"),
                      onPressed: () =>
                          callbackFunction(playerName, 4, 4), //4 = 'playerDef'
                    ),
                  ),
                ])),
          ],
        ),
      ),
    );
  }
}
