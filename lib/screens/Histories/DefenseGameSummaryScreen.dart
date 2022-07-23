// ignore_for_file: unnecessary_this

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/models/Game.dart';
import 'package:orbital_ultylitics/models/Player.dart';

class DefenseGameSummaryScreen extends StatefulWidget {
  final Game game;
  final String docID;

  const DefenseGameSummaryScreen({
    Key? key,
    required this.game,
    required this.docID,
  }) : super(key: key);

  @override
  State<DefenseGameSummaryScreen> createState() =>
      _DefenseGameSummaryScreenState(game: this.game, docID: this.docID);
}

class _DefenseGameSummaryScreenState extends State<DefenseGameSummaryScreen> {
  Game game;
  String docID;
  _DefenseGameSummaryScreenState({required this.game, required this.docID});

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
          return const Text("Loading");
        } else {
          return DataTable(
              headingRowColor: MaterialStateProperty.resolveWith((states) {
                return const Color.fromARGB(255, 255, 255, 255);
              }),
              sortAscending: true,
              sortColumnIndex: 0,
              dataRowColor: MaterialStateProperty.resolveWith(_getDataRowColor),
              columns: const [
                DataColumn(
                    label: Text('Name',
                        style: TextStyle(color: Colors.blueAccent))),
                DataColumn(
                    label: Text('Interceptions',
                        style: TextStyle(color: Colors.blueAccent)),
                    numeric: true),
                DataColumn(
                    label: Text('Pulling Rate',
                        style: TextStyle(color: Colors.blueAccent)),
                    numeric: true),
                DataColumn(
                    label: Text('Total Pulls',
                        style: TextStyle(color: Colors.blueAccent)),
                    numeric: true),
                DataColumn(
                    label: Text('O/B Pulls',
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
            style: const TextStyle(
                color: Colors.blueAccent, backgroundColor: Colors.white))),
        DataCell(Text(player.interception.toString(),
            style: const TextStyle(
                color: Colors.blueAccent, backgroundColor: Colors.white))),
        DataCell(Text(
            ((player.noOfPulls - player.obPulls) / player.noOfPulls)
                .toStringAsFixed(2),
            style: const TextStyle(
                color: Colors.blueAccent, backgroundColor: Colors.white))),
        DataCell(Text(((player.noOfPulls)).toStringAsFixed(2),
            style: const TextStyle(
                color: Colors.blueAccent, backgroundColor: Colors.white))),
        DataCell(Text(player.obPulls.toString(),
            style: const TextStyle(
                color: Colors.blueAccent, backgroundColor: Colors.white))),
      ]);
    }).toList() as List<DataRow>;
    return newList;
  }

  @override
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> players = getPlayerStats();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: false,
        backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text("Defense")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Game Details: ${game.gameDetails} ",
                  style: const TextStyle(color: Colors.white),
                )),
            Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: _buildBody(context))),
            )
          ],
        ));
  }
}
