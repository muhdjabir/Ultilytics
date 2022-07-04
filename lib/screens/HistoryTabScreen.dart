import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/screens/GameHistoryScreen.dart';
import 'package:orbital_ultylitics/screens/TeamHistoryScreen.dart';

class HistoryTabScreen extends StatefulWidget {
  const HistoryTabScreen({Key? key}) : super(key: key);
  @override
  _HistoryTabScreen createState() => _HistoryTabScreen();
}

class _HistoryTabScreen extends State<HistoryTabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            extendBodyBehindAppBar: false,
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text("History"),
              bottom: TabBar(tabs: [Tab(text: "Games"), Tab(text: "Teams")]),
            ),
            body: TabBarView(
              children: [GameHistoryScreen(), TeamHistoryScreen()],
            )));
  }
}
