import 'dart:ffi';

class Game {
  String? gameDetails;
  String? gameType;
  Int? myScore;
  String? teamName;
  String? opponentName;
  String? startingOn;
  Int? opponentScore;

  Game();

  Map<String, dynamic> toJson() => {
        'Game Details': gameDetails,
        'Game Type': gameType,
        'My Score': myScore,
        'My Team': teamName,
        'Opponents': opponentName,
        'Opponent Score': opponentScore,
        'Start O or D': startingOn
      };

  Game.fromSnapshot(snapshot)
      : gameDetails = snapshot.data()['Game Details'],
        gameType = snapshot.data()['Game Type'],
        myScore = snapshot.data()['My Score'],
        teamName = snapshot.data()['My Team'],
        opponentName = snapshot.data()['Opponents'],
        opponentScore = snapshot.data()['Opponent Score'],
        startingOn = snapshot.data()['Start O or D'];
}
