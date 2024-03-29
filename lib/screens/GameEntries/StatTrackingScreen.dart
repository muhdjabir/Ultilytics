// for working purposes to be copy pasted when creating a new screen that needs variables to be passed in
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/screens/customWidget/BlankPlayerWidget.dart';
import 'package:orbital_ultylitics/screens/customWidget/PullerWidget.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '../customWidget/OffenseThrowerWidget.dart';
import '../customWidget/DefensePlayerWidget.dart';
import '../customWidget/OffenseReceiverWidget.dart';
import '../customWidget/OffenseStartingWidget.dart';
import '../customWidget/DefenseStartingWidget.dart';
import '../customWidget/RoundButtonTimerWidget.dart';

var possibleStatus = [
  'startingOff', //0
  'receiverOff', //1
  'throwerOff', //2
  'startingDef', //3
  'playerDef', //4
  'puller', //5
  'blank', //6
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
      myPlayers: myPlayers,
      uid: uid,
      gameName: gameName,
      newPointState: newPointState,
      myScore: myScore,
      opponentScore: opponentScore,
      myTeam: myTeam,
      opponentTeam: opponentTeam,
      timeLeft: timeLeft,
      isPlaying: isPlaying);
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

  String getThrower(final playerStatus) {
    for (var player in playerStatus.keys) {
      if (playerStatus[player] == possibleStatus[2]) {
        return player;
      }
    }
    return "";
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: timeLeft,
    );
    setPlayersStatus(myPlayers, newPointState, playerStatus);
    opponentTeamName = getOpponentTeamName(opponentTeam);
    myTeamName = getOpponentTeamName(myTeam);
    if (isPlaying == true) {
      controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
    } else {
      controller.stop();
    }
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
  @override
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
                //print(playerStatus);
                //print('i am starting this point on $newPointState');
                //setPlayersStatus(myPlayers);
                //print('$myPlayers are my players');
                if (playerStatus[myPlayers[index]] == possibleStatus[0]) {
                  //startingOff
                  return OffenseStartingWidget(
                      myTeam: myTeam,
                      playerName: myPlayers[index],
                      playerStatus: playerStatus,
                      callbackFunction: callback,
                      uid: uid,
                      gameName: gameName);
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
                  //print('throweroffwidget activated');
                  return ThrowerOffWidget(
                    playerName: myPlayers[index],
                    playerStatus: playerStatus,
                    callbackFunction: callback,
                    uid: uid,
                    myTeam: myTeam,
                    gameName: gameName,
                  );
                }
                if (playerStatus[myPlayers[index]] == possibleStatus[3]) {
                  //starting Def
                  return DefenseStartingWidget(
                      playerName: myPlayers[index],
                      playerStatus: playerStatus,
                      callbackFunction: callback,
                      uid: uid,
                      gameName: gameName);
                }
                if (playerStatus[myPlayers[index]] == possibleStatus[4]) {
                  //player Def
                  //print('defplayerwidget activated');
                  return DefPlayerWidget(
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
                }
                if (playerStatus[myPlayers[index]] == possibleStatus[5]) {
                  return PullerWidget(
                      myTeam: myTeam,
                      playerName: myPlayers[index],
                      playerStatus: playerStatus,
                      callbackFunction: callback,
                      uid: uid,
                      gameName: gameName);
                }
                if (playerStatus[myPlayers[index]] == possibleStatus[6]) {
                  return BlankPlayerWidget(playerName: myPlayers[index]);
                } else {
                  //setPlayersStatus(myPlayers);
                  //print(playerStatus);
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
    return opponentTeam.substring(0, 6);
  } else {
    return opponentTeam;
  }
}
