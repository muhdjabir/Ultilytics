// for working purposes to be copy pasted when creating a new screen that needs variables to be passed in
import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/screens/customWidget/newpointpopupWidget.dart';
import 'customWidget/defensePlayerWidget.dart';
import 'customWidget/offenseReceiverWidget.dart';
import 'customWidget/offenseStartingWidget.dart';
import 'customWidget/defenseStartingWidget.dart';
import 'customWidget/offenseThrowerWidget.dart';
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
  StatTrackingScreen(
      {Key? key,
      required this.myPlayers,
      required this.uid,
      required this.gameName,
      required this.newPointState})
      : super(key: key);

  @override
  State<StatTrackingScreen> createState() => _StatTrackingScreenState(
      myPlayers: this.myPlayers,
      uid: this.uid,
      gameName: this.gameName,
      newPointState: this.newPointState);
}

class _StatTrackingScreenState extends State<StatTrackingScreen> {
  var myPlayers;
  String uid;
  String gameName;
  String newPointState;
  @override
  _StatTrackingScreenState(
      {required this.myPlayers,
      required this.uid,
      required this.gameName,
      required this.newPointState});
  var playerStatus = {};

  void initState() {
    super.initState();
    setPlayersStatus(myPlayers, newPointState, playerStatus);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(children: [
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
                  );
                }
                if (playerStatus[myPlayers[index]] == possibleStatus[2]) {
                  //thrower Offense
                  print('throweroffwidget activated');
                  return ThrowerOffWidget(
                      playerName: myPlayers[index],
                      playerStatus: playerStatus,
                      callbackFunction: callback);
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
                      uid: uid);
                }
                /*if (playerStatus[myPlayers[index]] == possibleStatus[5] || playerStatus[myPlayers[index]] == possibleStatus[6]) {
                  //won the previous point
                  return newPointPopupWidget(state: myPlayers[index], gameName: gameName, uid: uid, myPlayersLength: myPlayers.length);
                  /*Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => NewLineScreen(gameName: gameName,uid: uid,newPointState: 'Defense',numPlayers: myPlayers.length,)));
                  return Text("hello");*/
                }*/
                /*if (playerStatus[myPlayers[index]] == possibleStatus[6]) {
                  //lost the previous point
                  return ThrowerOffWidget(
                      playerName: myPlayers[index],
                      playerStatus: playerStatus,
                      callbackFunction: callback);
                } */
                else {
                  //setPlayersStatus(myPlayers);
                  print(playerStatus);
                  return Text(
                    'no widget yet',
                    style: TextStyle(color: Colors.white),
                  );
                }
              }),
            )
            //List
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
