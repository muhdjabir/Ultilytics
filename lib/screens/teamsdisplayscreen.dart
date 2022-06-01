import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:orbital_ultylitics/screens/HomePage.dart';
import 'package:orbital_ultylitics/screens/createteamscreen.dart';
import 'package:orbital_ultylitics/screens/profilescreen.dart';
//import 'ProfileScreen.dart';
import '../namewidget.dart';
import 'settingscreen.dart';

class TeamsDisplayScreen extends StatefulWidget {
  const TeamsDisplayScreen({Key? key}) : super(key: key);

  @override
  State<TeamsDisplayScreen> createState() => _TeamsDisplayScreenState();
}

class _TeamsDisplayScreenState extends State<TeamsDisplayScreen> {
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference usersCollectionRef =
      FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            //add player button
            icon: const Icon(Icons.group_add_outlined),
            onPressed: () {
              usersCollectionRef.doc().collection;
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) =>
                      /*const ProfileScreen(index: 2)*/
                      const CreateTeamScreen(),
                ),
              );
            },
          ),
        ],
        title: const Text("Your Teams"),
      ),
      body: Center(
        child: Container(
          height: 250,
          padding: const EdgeInsets.symmetric(vertical: 20),
          /*child: StreamBuilder<QuerySnapshot>(
            stream: users,
            builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot,
            ) {
              if (snapshot.hasError) {
                return Text('Something went wrong.');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('loading');
              }

              final data = snapshot.requireData;
              /*return ListView.builder(
                  //https://www.youtube.com/watch?v=TcwQ74WVTTc
                  itemCount: data.size,
                  itemBuilder: (context, index) {
                    //insert return widget(with a dropdown menu for editing the given team)
                    return NameWidget();
                  });*/
            },
          ),*/

          //listplayers(),
        ),
      ),
      /*child: ListView.builder(
      children
    )*/
    );
  }
}
