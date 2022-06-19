// for working purposes to be copy pasted when creating a new screen that needs variables to be passed in
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:orbital_ultylitics/screens/customWidget/OffenseThrowerWidget.dart';
import 'customWidget/offenseReceiverWidget.dart';
import 'customWidget/OffenseStartingWidget.dart';

var status = [
  'startingOff',
  'receiverOff',
  'throwerOff',
  'startingDef',
  'playerDef'
];

//https://www.youtube.com/watch?v=zq-JGQxNwtU CALLBACK FUNCTIONSSS

void setPlayersStatus(final playerStatus, final myPlayers) {
  for (var i = 0; i < myPlayers.length; i += 1) {
    playerStatus[myPlayers[i]] = status[0];
  }
}

class statTrackingScreen extends StatefulWidget {
  var myPlayers;
  String uid;
  statTrackingScreen({Key? key, required this.myPlayers, required this.uid})
      : super(key: key);

  @override
  State<statTrackingScreen> createState() =>
      _statTrackingScreenState(myPlayers: this.myPlayers, uid: this.uid);
}

class _statTrackingScreenState extends State<statTrackingScreen> {
  var myPlayers;
  String uid;
  @override
  _statTrackingScreenState({required this.myPlayers, required this.uid});
  var playerStatus = {};

  void setPlayersStatus(final myPlayers) {
    for (var i = 0; i < myPlayers.length; i += 1) {
      playerStatus[myPlayers[i]] = status[0];
    }
  }

  void initState() {
    super.initState();
    setPlayersStatus(myPlayers);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Expanded(
            child: Column(children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: playerStatus.length,
                itemBuilder: ((context, index) {
                  print('$myPlayers are my players');
                  if (playerStatus[myPlayers[index]] == status[0]) {
                    //startingOff
                    return OffenseStartingWidget(
                        playerName: myPlayers[index],
                        playerStatus: playerStatus,
                        callbackFunction: callback);
                  }
                  if (playerStatus[myPlayers[index]] == status[1]) {
                    // receiverOff
                    return ReceiverOffWidget(
                        playerName: myPlayers[index],
                        playerStatus: playerStatus);
                  }
                  if (playerStatus[myPlayers[index]] == status[2]) {
                    //thrower Offense
                    return ThrowerOffWidget(
                        playerName: myPlayers[index],
                        playerStatus: playerStatus);
                  } else {
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
      ),
    );
  }

  callback(playerName, uniqueStatus, othersStatus) {
    setState(() {
      playerStatus.keys.forEach((k) {
        if (k == playerName) {
          playerStatus[playerName] = status[uniqueStatus];
          print(playerStatus);
        } else {
          playerStatus[k] = status[othersStatus];
          print(playerStatus);
        }
      });
    });
  }
}
