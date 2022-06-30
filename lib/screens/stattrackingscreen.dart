// for working purposes to be copy pasted when creating a new screen that needs variables to be passed in
//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/screens/customWidget/newpointpopupWidget.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '../models/Game.dart';
import 'customWidget/defensePlayerWidget.dart';
import 'customWidget/offenseReceiverWidget.dart';
import 'customWidget/offenseStartingWidget.dart';
import 'customWidget/defenseStartingWidget.dart';
import 'customWidget/offenseThrowerWidget.dart';
import 'customWidget/roundButtonTimerWidget.dart';
import 'newLineScreen.dart';

var possibleStatus = [
  'startingOff',
  'receiverOff',
  'throwerOff',
  'startingDef',
  'playerDef',
  'winpoint',
  'lostpoint',
];

//https://www.youtube.com/watch?v=zq-JGQxNwtU CALLBACK FUNCTIONSSS

/*void setPlayersStatus(final playerStatus, final myPlayers) {
  for (var i = 0; i < myPlayers.length; i += 1) {
    playerStatus[myPlayers[i]] = possibleStatus[0];
  }
}*/
void setPlayersStatus(final myPlayers, newPointState, playerStatus) {
  for (var i = 0; i < myPlayers.length; i += 1) {
    if (newPointState == 'Offense') {
      playerStatus[myPlayers[i]] = possibleStatus[0];
    } else {
      playerStatus[myPlayers[i]] = possibleStatus[3];
    }
  }
}

class StatTrackingScreen extends StatefulWidget {
  var myPlayers;
  String uid;
  String gameName;
  String newPointState;
  var myScore;
  var opponentScore;
  String myTeam;
  String opponentTeam;
  Duration timeLeft;
  bool isPlaying;

  StatTrackingScreen(
      {Key? key,
      required this.myPlayers,
      required this.uid,
      required this.gameName,
      required this.newPointState,
      required this.myScore,
      required this.opponentScore,
      required this.myTeam,
      required this.opponentTeam,
      required this.timeLeft,
      required this.isPlaying})
      : super(key: key);

  @override
  State<StatTrackingScreen> createState() => _StatTrackingScreenState(
      myPlayers: this.myPlayers,
      uid: this.uid,
      gameName: this.gameName,
      newPointState: this.newPointState,
      myScore: this.myScore,
      opponentScore: this.opponentScore,
      myTeam: this.myTeam,
      opponentTeam: this.opponentTeam,
      timeLeft: this.timeLeft,
      isPlaying: this.isPlaying);
}

class _StatTrackingScreenState extends State<StatTrackingScreen>
    with TickerProviderStateMixin {
  var myPlayers;
  String uid;
  String gameName;
  String newPointState;
  var myScore;
  var opponentScore;
  String myTeam;
  String opponentTeam;
  bool isPlaying;
  late AnimationController controller;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  Duration timeLeft;
  final _isHours = true;

  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: timeLeft,
    );
    setPlayersStatus(myPlayers, newPointState, playerStatus);
    opponentTeamName = getOpponentTeamName(opponentTeam);
    myTeamName = getOpponentTeamName(myTeam);
    if (isPlaying == true)
    {controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);}
    else{controller.stop();}
  }

  @override
  void dispose() {
    controller.dispose();
    _stopWatchTimer.dispose();
    super.dispose();
  }

  String get countText {
    Duration count = controller.duration! * controller.value;
    return '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  _StatTrackingScreenState(
      {required this.myPlayers,
      required this.uid,
      required this.gameName,
      required this.newPointState,
      required this.myScore,
      required this.opponentScore,
      required this.myTeam,
      required this.opponentTeam,
      required this.timeLeft,
      required this.isPlaying});
  var playerStatus = {};
  late String opponentTeamName;
  late String myTeamName;
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(children: [
            Row(children: [
              AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) => Text(countText,
                      style: const TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70))),
              GestureDetector(
                  onTap: () {
                    if (controller.isAnimating) {
                      controller.stop();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      controller.reverse(
                          from: controller.value == 0 ? 1.0 : controller.value);
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  child: RoundButton(
                    color: isPlaying == true
                        ? Colors.yellow[700]
                        : Colors.green[700],
                    icon: isPlaying == true ? Icons.pause : Icons.play_arrow,
                  ))
            ]),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: playerStatus.length,
              itemBuilder: ((context, index) {
                print(playerStatus);
                print('i am starting this point on $newPointState');
                //setPlayersStatus(myPlayers);
                print('$myPlayers are my players');
                if (playerStatus[myPlayers[index]] == possibleStatus[0]) {
                  //startingOff
                  return OffenseStartingWidget(
                      playerName: myPlayers[index],
                      playerStatus: playerStatus,
                      callbackFunction: callback);
                }
                if (playerStatus[myPlayers[index]] == possibleStatus[1]) {
                  // receiverOff
                  return ReceiverOffWidget(
                    playerName: myPlayers[index],
                    playerStatus: playerStatus,
                    callbackFunction: callback,
                    uid: uid,
                    gameName: gameName,
                    myScore: myScore,
                    myTeam: myTeam,
                    opponentScore: opponentScore,
                    opponentTeam: opponentTeam,
                    timeLeft: controller.duration! * controller.value,
                    isPlaying: isPlaying,
                  );
                }
                if (playerStatus[myPlayers[index]] == possibleStatus[2]) {
                  //thrower Offense
                  print('throweroffwidget activated');
                  return ThrowerOffWidget(
                    playerName: myPlayers[index],
                    playerStatus: playerStatus,
                    callbackFunction: callback,
                    uid: uid,
                    gameName: gameName,
                  );
                }
                if (playerStatus[myPlayers[index]] == possibleStatus[3]) {
                  //starting Def
                  return defenseStartingWidget(
                      playerName: myPlayers[index],
                      playerStatus: playerStatus,
                      callbackFunction: callback);
                }
                if (playerStatus[myPlayers[index]] == possibleStatus[4]) {
                  //player Def
                  print('defplayerwidget activated');
                  return defPlayerWidget(
                    playerName: myPlayers[index],
                    playerStatus: playerStatus,
                    callbackFunction: callback,
                    gameName: gameName,
                    uid: uid,
                    myScore: myScore,
                    myTeam: myTeam,
                    opponentScore: opponentScore,
                    opponentTeam: opponentTeam,
                    timeLeft: controller.duration! * controller.value,
                    isPlaying: isPlaying,
                  );
                } else {
                  //setPlayersStatus(myPlayers);
                  print(playerStatus);
                  return const Text(
                    'no widget yet',
                    style: TextStyle(color: Colors.white),
                  );
                }
              }),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  child: Column(
                    children: [
                      Text(myScore.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                              fontSize: 40)),
                      Text(myTeamName, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                Container(
                    width: 20,

                    //alignment: Alignment.Centre,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(3, 0, 0, 20),
                        child: Text("-",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                fontSize: 40)))),
                Container(
                    width: 60,
                    child: Column(
                      children: [
                        Text(opponentScore.toString(),
                            softWrap: true,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                fontSize: 40)),
                        Text(opponentTeamName,
                            style: TextStyle(color: Colors.white)),
                      ],
                    )),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  callback(playerName, uniqueStatus, othersStatus) {
    setState(() {
      playerStatus.keys.forEach((k) {
        if (k == playerName) {
          playerStatus[playerName] = possibleStatus[uniqueStatus];
          //print(playerStatus);
        } else {
          playerStatus[k] = possibleStatus[othersStatus];
          //print(playerStatus);
        }
      });
    });
  }
}

String getOpponentTeamName(final opponentTeam) {
  if (opponentTeam.length >= 9) {
    return opponentTeam.substring(0, 7);
  } else {
    return opponentTeam;
  }
}
/*
class CustomButton extends StatelessWidget {
  var color;
  var onPress;
  final String label;
  CustomButton(
      {required this.color, required this.onPress, required this.label});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      //shape:,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0), // radius you want
                  side: BorderSide(
                    color: Colors.transparent, //color
                  )))),
      onPressed: onPress,
      child: Text(label, style: TextStyle(color: Colors.white)),
    );
  }
}
*/

