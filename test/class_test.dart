import 'package:orbital_ultylitics/models/Game.dart';
import 'package:orbital_ultylitics/models/Player.dart';
import 'package:orbital_ultylitics/models/Team.dart';
import 'package:test/test.dart';

void main() {
  group('Classes', () {
    test('Teams Smoke Test', () {
      Team team = Team(1, 2, 3, "Testing Team", 100, 0);

      expect(team.loses, 1);
      expect(team.wins, 2);
      expect(team.noOfPlayers, 3);
      expect(team.teamName, "Testing Team");
      expect(team.winRate, 100);
      expect(team.draws, 0);
    });

    test('Player Smoke Test', () {
      Player player = Player(
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        "Player Test",
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
      );

      expect(player.assists, 1);
      expect(player.advantageousThrows, 2);
      expect(player.catches, 3);
      expect(player.totalThrows, 4);
      expect(player.goalScored, 5);
      expect(player.interception, 6);
      expect(player.throwaways, 7);
      expect(player.name, "Player Test");
      expect(player.noOfPulls, 8);
      expect(player.plusMinus, 9);
      expect(player.stalledOut, 10);
      expect(player.averagePullTime, 11);
      expect(player.obPulls, 12);
      expect(player.averageDiscTime, 13);
      expect(player.drops, 14);
      expect(player.touches, 15);
      expect(player.pointsPlayed, 16);
    });

    test("Game Smoke Test", () {
      Game game = Game("Testing GAME CLASS", "Test", 3, "My Team",
          "Opponent Team", "Offense", 2);

      expect(game.gameDetails, "Testing GAME CLASS");
      expect(game.gameType, "Test");
      expect(game.myScore, 3);
      expect(game.teamName, "My Team");
      expect(game.opponentName, "Opponent Team");
      expect(game.startingOn, "Offense");
      expect(game.opponentScore, 2);
    });
  });
}
