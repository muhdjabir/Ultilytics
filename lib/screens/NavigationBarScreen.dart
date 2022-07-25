import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/screens/Histories/HistoryTabScreen.dart';
import 'package:orbital_ultylitics/screens/GameEntries/NewGameScreen.dart';
import 'package:orbital_ultylitics/screens/TeamEntries/TeamsDisplayScreen.dart';
import 'settingscreen.dart';

class NavigationBarScreen extends StatefulWidget {
  final int index;
  const NavigationBarScreen({Key? key, this.index = 0}) : super(key: key);

  @override
  State<NavigationBarScreen> createState() =>
      _NavigationBarScreenState(index: index);
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  //CollectionReference users = FirebaseFirestore.instance.collection('users');

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
        data: NavigationBarThemeData(
          indicatorColor: Colors.blue.shade100,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        child: PageStorage(
          bucket: bucket,
          child: NavigationBar(
            //Creating the navigation bar to navigate between History, Teams, Games and Settings
            height: 60,
            backgroundColor: Colors.blueGrey,
            selectedIndex: index,
            onDestinationSelected: (index) =>
                setState(() => this.index = index),
            destinations: const [
              NavigationDestination(
                  key: ValueKey("historyTab"),
                  icon: Icon(Icons.history_outlined),
                  selectedIcon: Icon(Icons.history),
                  label: "History"),
              NavigationDestination(
                  key: ValueKey("teamTab"),
                  icon: Icon(Icons.group_outlined),
                  selectedIcon: Icon(Icons.group),
                  label: "Teams"),
              NavigationDestination(
                  key: ValueKey("gameTab"),
                  icon: Icon(Icons.library_add_outlined),
                  selectedIcon: Icon(Icons.library_add),
                  label: "New Game"),
              NavigationDestination(
                  key: ValueKey("settingsTab"),
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
