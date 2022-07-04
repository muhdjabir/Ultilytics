class Team {
  late final int loses;
  late final int wins;
  late final int noOfPlayers;
  late final String teamName;
  late final int winRate;

  Team();

  Map<String, dynamic> toJson() => {
        "Loses": loses,
        "Wins": wins,
        "Number of Players": noOfPlayers,
        "Team Name": teamName,
        "Win Rate": winRate
      };

  Team.fromSnapshot(snapshot)
      : loses = snapshot.data()["Loses"],
        wins = snapshot.data()["Wins"],
        noOfPlayers = snapshot.data()["Number of Players"],
        teamName = snapshot.data()["Team Name"],
        winRate = snapshot.data()["Win Rate"];
}
