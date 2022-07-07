import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/models/Game.dart';
import 'package:orbital_ultylitics/screens/GameHistoryScreen.dart';
import 'package:orbital_ultylitics/screens/HistoryTabScreen.dart';
import 'package:orbital_ultylitics/screens/NewGameScreen.dart';
import 'package:orbital_ultylitics/screens/TeamsDisplayScreen.dart';
import 'settingscreen.dart';

class NavigationBarScreen extends StatefulWidget {
  final int index;
  const NavigationBarScreen({Key? key, this.index = 0}) : super(key: key);

  @override
  State<NavigationBarScreen> createState() =>
      _NavigationBarScreenState(index: index);
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  int index;
  _NavigationBarScreenState({required this.index});
  final screens = const [
    HistoryTabScreen(),
    TeamsDisplayScreen(),
    NewGameScreen(key: PageStorageKey("NewGameScreen")),
    SettingsScreen(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        //navigation bar implmentation video https://www.youtube.com/watch?v=2emB2VFrRnA
        data: NavigationBarThemeData(
          indicatorColor: Colors.blue.shade100,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        child: PageStorage(
          bucket: bucket,
          child: NavigationBar(
            height: 60,
            backgroundColor: Colors.blueGrey,
            selectedIndex: index,
            onDestinationSelected: (index) =>
                setState(() => this.index = index),
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.history_outlined),
                  selectedIcon: Icon(Icons.history),
                  label: "History"),
              NavigationDestination(
                  icon: Icon(Icons.group_outlined),
                  selectedIcon: Icon(Icons.group),
                  label: "Teams"),
              NavigationDestination(
                  icon: Icon(Icons.library_add_outlined),
                  selectedIcon: Icon(Icons.library_add),
                  label: "New Game"),
              NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: "Settings"),
            ],
          ),
        ),
      ),
    );
  }
}
