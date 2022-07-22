import 'dart:ffi';

class Player {
  late final int assists;
  late final int advantageousThrows;
  late final int catches;
  late final int totalThrows;
  late final int goalScored;
  late final int interception;
  late final int throwaways;
  late final String name;
  late final int noOfPulls;
  late final int plusMinus;
  late final int stalledOut;
  late final int averagePullTime;
  late final int obPulls;
  late final int averageDiscTime;
  late final int drops;
  late final int touches;

  Player();

  Map<String, dynamic> toJson() => {
        "Assists": assists,
        "Advantageous Throw": advantageousThrows,
        "Catch": catches,
        "Goals Scored": goalScored,
        "Interception": interception,
        "Throwaways": throwaways,
        "Player Name": name,
        "Total Throws": totalThrows,
        "Number of Pulls": noOfPulls,
        "Plus-Minus": plusMinus,
        "Stalled Out": stalledOut,
        "Average Pull Time": averagePullTime,
        "Out of Bounds Pull": obPulls,
        "Average Disc Time": averageDiscTime,
        "Drops": drops,
        "Touches": touches
      };

  Player.fromSnapshot(snapshot)
      : assists = snapshot.data()["Assists"],
        advantageousThrows = snapshot.data()["Advantageous Throw"],
        catches = snapshot.data()["Catch"],
        goalScored = snapshot.data()["Goals Scored"],
        interception = snapshot.data()["Interception"],
        totalThrows = snapshot.data()["Total Throws"],
        noOfPulls = snapshot.data()["Number of Pulls"],
        plusMinus = snapshot.data()["Plus-Minus"],
        stalledOut = snapshot.data()["Stalled Out"],
        averagePullTime = snapshot.data()["Average Pull Time"],
        averageDiscTime = snapshot.data()["Average Disc Time"],
        obPulls = snapshot.data()["Number of Pulls"],
        throwaways = snapshot.data()["Throwaways"],
        drops = snapshot.data()["Drops"],
        touches = snapshot.data()["Touches"],
        name = snapshot.data()["Player Name"];
  //drops = snapshot.data()["Drops"];
}
