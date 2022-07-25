import 'dart:ffi';

class Team {
  late final int loses;
  late final int wins;
  late final int noOfPlayers;
  late final String teamName;
  late final int winRate;
  late final int draws;

  Team(int loses, int wins, int noOfPlayers, String teamName, int winRate,
      int draws) {
    this.loses = loses;
    this.wins = wins;
    this.noOfPlayers = noOfPlayers;
    this.teamName = teamName;
    this.winRate = winRate;
    this.draws = draws;
  }

  Map<String, dynamic> toJson() => {
        "Loses": loses,
        "Wins": wins,
        "Number of Players": noOfPlayers,
        "Team Name": teamName,
        "Win Rate": winRate,
        "Draws": draws,
      };

  Team.fromSnapshot(snapshot)
      : loses = snapshot.data()["Loses"],
        wins = snapshot.data()["Wins"],
        noOfPlayers = snapshot.data()["Number of Players"],
        teamName = snapshot.data()["Team Name"],
        draws = snapshot.data()["Draws"],
        winRate = snapshot.data()["Win Rate"];
}
