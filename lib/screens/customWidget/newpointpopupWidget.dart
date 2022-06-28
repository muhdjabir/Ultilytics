import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../newLineScreen.dart';

class newPointPopupWidget extends StatefulWidget {
  var state;
  String gameName;
  String uid;
  var myPlayersLength;
  newPointPopupWidget(
      {Key? key,
      required this.state,
      required this.gameName,
      required this.uid,
      required this.myPlayersLength})
      : super(key: key);

  @override
  State<newPointPopupWidget> createState() => _newPointPopupWidgetState(
      state: this.state,
      gameName: this.gameName,
      uid: this.uid,
      myPlayersLength: this.myPlayersLength);
}

class _newPointPopupWidgetState extends State<newPointPopupWidget> {
  _newPointPopupWidgetState(
      {required this.state,
      required this.gameName,
      required this.uid,
      required this.myPlayersLength});
  var state;
  String gameName;
  String uid;
  var myPlayersLength;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: AlertDialog(
      content: Text('Are you starting the next point on Offense or Defense?'),
      actions: [
        TextButton(
            child: Text('Offense'),
            onPressed: () => MaterialPageRoute(
                builder: (BuildContext context) => NewLineScreen(
                      gameName: gameName,
                      uid: uid,
                      newPointState: 'Offense',
                      numPlayers: myPlayersLength,
                    ))),
        TextButton(
            child: Text('Defense'),
            onPressed: () => MaterialPageRoute(
                builder: (BuildContext context) => NewLineScreen(
                      gameName: gameName,
                      uid: uid,
                      newPointState: 'Defense',
                      numPlayers: myPlayersLength,
                    )))
      ],
    )));
  }
}