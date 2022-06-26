import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/models/Game.dart';
import 'package:orbital_ultylitics/models/Player.dart';

class GameSummaryScreen extends StatefulWidget {
  final Game game;
  final String docID;

  const GameSummaryScreen({
    Key? key,
    required this.game,
    required this.docID,
  }) : super(key: key);

  @override
  State<GameSummaryScreen> createState() =>
      _GameSummaryScreenState(game: this.game, docID: this.docID);
}

class _GameSummaryScreenState extends State<GameSummaryScreen> {
  Game game;
  String docID;
  _GameSummaryScreenState({required this.game, required this.docID});

  Stream<QuerySnapshot> getPlayerStats() {
    FirebaseAuth auth = FirebaseAuth
        .instance; // Acquiring individual player statistics from this game
    User? user = auth.currentUser;
    String uid = user!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('games')
        .doc(docID)
        .collection('players')
        .snapshots();
  }

  Color _getDataRowColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };

    if (states.any(interactiveStates.contains)) {
      return Colors.green;
    }
    //return Colors.green; // Use the default value.
    return Colors.white;
  }

  Widget _buildBody(BuildContext context) {
    //Method for the creation of the DataTable
    return StreamBuilder<QuerySnapshot>(
      //Widget comprising of player statistcs
      stream: getPlayerStats(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        } else {
          return DataTable(
              headingRowColor: MaterialStateProperty.resolveWith((states) {
                return Color.fromARGB(255, 255, 255, 255);
              }),
              sortAscending: true,
              sortColumnIndex: 0,
              dataRowColor: MaterialStateProperty.resolveWith(_getDataRowColor),
              columns: [
                DataColumn(
                    label: Text('Name',
                        style: TextStyle(color: Colors.blueAccent))),
                DataColumn(
                    label: Text('Scores',
                        style: TextStyle(color: Colors.blueAccent)),
                    numeric: true),
                DataColumn(
                    label: Text('Assists',
                        style: TextStyle(color: Colors.blueAccent)),
                    numeric: true),
                DataColumn(
                    label: Text('Throwaways',
                        style: TextStyle(color: Colors.blueAccent)),
                    numeric: true),
                DataColumn(
                    label: Text('Interceptions',
                        style: TextStyle(color: Colors.blueAccent)),
                    numeric: true),
                DataColumn(
                    label: Text('Catches',
                        style: TextStyle(color: Colors.blueAccent)),
                    numeric: true),
                DataColumn(
                    label: Text('Openside Throws',
                        style: TextStyle(color: Colors.blueAccent)),
                    numeric: true),
                DataColumn(
                    label: Text('Breakside Throws',
                        style: TextStyle(color: Colors.blueAccent)),
                    numeric: true)
              ],
              rows: _buildList(snapshot.data));
        }
      },
    );
  }

  List<DataRow> _buildList(QuerySnapshot? snapshot) {
    //Method for populating the rows of DataTable
    List<DataRow> newList =
        snapshot?.docs.map((DocumentSnapshot documentSnapshot) {
      Player player = Player.fromSnapshot(documentSnapshot);
      return DataRow(cells: [
        DataCell(Text(player.name.toString(),
            style: TextStyle(
                color: Colors.blueAccent, backgroundColor: Colors.white))),
        DataCell(Text(player.goalScored.toString(),
            style: TextStyle(
                color: Colors.blueAccent, backgroundColor: Colors.white))),
        DataCell(Text(player.assists.toString(),
            style: TextStyle(
                color: Colors.blueAccent, backgroundColor: Colors.white))),
        DataCell(Text(player.throwaways.toString(),
            style: TextStyle(
                color: Colors.blueAccent, backgroundColor: Colors.white))),
        DataCell(Text(player.interception.toString(),
            style: TextStyle(
                color: Colors.blueAccent, backgroundColor: Colors.white))),
        DataCell(Text(player.catches.toString(),
            style: TextStyle(
                color: Colors.blueAccent, backgroundColor: Colors.white))),
        DataCell(Text(player.opensideThrows.toString(),
            style: TextStyle(
                color: Colors.blueAccent, backgroundColor: Colors.white))),
        DataCell(Text(player.breaksideThrows.toString(),
            style: TextStyle(
                color: Colors.blueAccent, backgroundColor: Colors.white))),
      ]);
    }).toList() as List<DataRow>;
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> players = getPlayerStats();
    print(players.toList());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: false,
        backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text("${game.teamName} vs ${game.opponentName}")),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, child: _buildBody(context)),
        ));
  }
}
