import 'package:flutter/material.dart';

import '../newLineScreen.dart';

class newPointPopupWidget extends StatefulWidget {
  var state;
  String gameName;
  String uid;
  var myPlayersLength;
  var myScore;
  var opponentScore;
  String myTeam;
  String opponentTeam;
  newPointPopupWidget(
      {Key? key,
      required this.state,
      required this.gameName,
      required this.uid,
      required this.myPlayersLength,
      required this.myScore,
      required this.opponentScore,
      required this.myTeam,
      required this.opponentTeam})
      : super(key: key);

  @override
  State<newPointPopupWidget> createState() => _newPointPopupWidgetState(
      state: this.state,
      gameName: this.gameName,
      uid: this.uid,
      myPlayersLength: this.myPlayersLength,
      myScore: this.myScore,
      opponentScore: this.opponentScore,
      myTeam: this.myTeam,
      opponentTeam: this.opponentTeam);

}

class _newPointPopupWidgetState extends State<newPointPopupWidget> {
  _newPointPopupWidgetState(
      {required this.state,
      required this.gameName,
      required this.uid,
      required this.myPlayersLength,
      required this.myScore,
      required this.opponentScore,
      required this.myTeam,
      required this.opponentTeam});
  var state;
  String gameName;
  String uid;
  var myPlayersLength;
  var myScore;
  var opponentScore;
  String myTeam;
  String opponentTeam;
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
                      myScore: myScore,
                      myTeam: myTeam,
                      opponentScore: opponentScore,
                      opponentTeam: opponentTeam,
                      timeLeft: ,
                    ))),
        TextButton(
            child: Text('Defense'),
            onPressed: () => MaterialPageRoute(
                builder: (BuildContext context) => NewLineScreen(
                      gameName: gameName,
                      uid: uid,
                      newPointState: 'Defense',
                      numPlayers: myPlayersLength,
                      myScore: myScore,
                      myTeam: myTeam,
                      opponentScore: opponentScore,
                      opponentTeam: opponentTeam,
                    )))
      ],
    )));
  }
}*/
