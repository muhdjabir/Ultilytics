import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BlankPlayerWidget extends StatefulWidget {
  var playerName;
  BlankPlayerWidget({
    Key? key,
    required this.playerName,
  }) : super(key: key);

  @override
  State<BlankPlayerWidget> createState() => _BlankPlayerWidgetState(
        playerName: this.playerName,
      );
}

class _BlankPlayerWidgetState extends State<BlankPlayerWidget> {
  _BlankPlayerWidgetState({required this.playerName});
  var playerName;
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
          ],
        ),
      ),
    );
  }
}
