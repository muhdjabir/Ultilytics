import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/models/Player.dart';
import 'package:orbital_ultylitics/models/Team.dart';
import 'package:orbital_ultylitics/screens/Histories/OffenseGameSummary.dart';

class DefenseTeamSummaryScreen extends StatefulWidget {
  final Team team;
  final String docID;

  const DefenseTeamSummaryScreen({
    Key? key,
    required this.team,
    required this.docID,
  }) : super(key: key);

  @override
  State<DefenseTeamSummaryScreen> createState() =>
      _DefenseTeamSummaryScreenState(team: team, docID: docID);
}

class _DefenseTeamSummaryScreenState extends State<DefenseTeamSummaryScreen> {
  Team team;
  String docID;
  _DefenseTeamSummaryScreenState({required this.team, required this.docID});

  Stream<QuerySnapshot> getPlayerStats() {
    FirebaseAuth auth = FirebaseAuth
        .instance; // Acquiring individual player statistics from this team
    User? user = auth.currentUser;
    String uid = user!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('teams')
        .doc(team.teamName)
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Wins: ${team.wins}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20)),
                    Text(
                      "Losses: ${team.loses}",
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      "Draws: ${team.draws}",
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
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
