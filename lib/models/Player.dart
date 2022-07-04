class Player {
  late final int assists;
  late final int breaksideThrows;
  late final int catches;
  late final int goalScored;
  late final int interception;
  late final int opensideThrows;
  late final int throwaways;
  late final String name;

  Player();

  Map<String, dynamic> toJson() => {
        "Assists": assists,
        "Breakside Throws": breaksideThrows,
        "Catch": catches,
        "Goals Scored": goalScored,
        "Interception": interception,
        "Openside Throws": opensideThrows,
        "Throwaways": throwaways,
        "Player Name": name
      };

  Player.fromSnapshot(snapshot)
      : assists = snapshot.data()["Assists"],
        breaksideThrows = snapshot.data()["Breakside Throws"],
        catches = snapshot.data()["Catch"],
        goalScored = snapshot.data()["Goals Scored"],
        interception = snapshot.data()["Interception"],
        opensideThrows = snapshot.data()["Openside Throws"],
        throwaways = snapshot.data()["Throwaways"],
        name = snapshot.data()["Player Name"];
}
