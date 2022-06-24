/*
Features to include
App Bar opponent
Game Details
List of Players
Player stats
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/models/Game.dart';

class GameSummaryScreen extends StatelessWidget {
  final Game game;

  const GameSummaryScreen({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(game.teamName.toString())),
    );
  }
}
