import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:orbital_ultylitics/screens/NewGameScreen.dart';
import 'package:orbital_ultylitics/screens/NavigationBarScreen.dart';
//import 'package:orbital_ultylitics/screens/StatTrackingScreen.dart';
import 'package:orbital_ultylitics/screens/stattrackingscreen.dart';

class NewLineScreen extends StatefulWidget {
  //List<String> myPlayers;
  String gameName;
  String uid;
  var newPointState;
  var numPlayers;
  NewLineScreen(
      {Key? key,
      required this.gameName,
      required this.numPlayers,
      //required this.myPlayers,
      required this.uid,
      required this.newPointState})
      : super(key: key);

  @override
  State<NewLineScreen> createState() => _NewLineScreenState(
      numPlayers: this.numPlayers, uid: this.uid,gameName: this.gameName, newPointState: this.newPointState);
}

class _NewLineScreenState extends State<NewLineScreen> {
  var numPlayers;
  bool? _isChecked = false;
  //List<String> myPlayers;
  String uid;
  String gameName;
  var newPointState;
  //Int numPlayers;
  List<bool> isChecked = [];
  var lineupList = [];
  Future<bool?> getData() async {
    print('is checked has $numPlayers');
    for (var i = 0; i < numPlayers; i += 1) {
      isChecked.add(false);
    }
  }

  Future<void> getLineupList(final uid, final gameName) async {
    var index = 0;
    lineupList = [];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('games')
        .doc(gameName)
        .collection('players')
        .get()
        .then((snapshot) => (snapshot.docs.forEach((document) {
              if (isChecked[index] == true) {
                lineupList.add(document.reference.id);
              }
              index += 1;
            })));
    //numPlayers = myPlayers.length;
  }

  int numSelected = 0;
  var numSelectedString = "0";
  Future<bool?> getNumSelected() async {
    numSelected = 0;
    for (var i = 0; i < numPlayers; i += 1) {
      if (isChecked[i] == true) {
        numSelected += 1;
      }
    }
    print(numSelected);
  }

  @override
  _NewLineScreenState(
      {required this.gameName,
      required this.numPlayers,
      /*required this.myPlayers,*/ required this.uid, required this.newPointState});
  Widget build(BuildContext context) {
    getData();
    print("$numPlayers number of players");
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      //print("$numPlayers number of players");
      //getData();
      getNumSelected();
      //if(numSelected!=0){
      numSelectedString = numSelected.toString();
      //}
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            leadingWidth: 50,
            leading: IconButton(
              onPressed: () {
                isChecked = [];
                //Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NavigationBarScreen(index: 2),
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_sharp,
                size: 15,
              ),
              //label: const Text(''),
              //style: ElevatedButton.styleFrom(
              //  elevation: 0, primary: Colors.transparent,),
            ),
            /*actions: <Widget>[
          IconButton(
            //add new team button
            icon: const Icon(Icons.group_add_outlined),
            onPressed: () async {
              createAlertDialog(context);
            },
          ),
        ],*/
            title: Text("$newPointState lineup: $numSelectedString players selected "),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .collection('games')
                          .doc(gameName)
                          .collection('players')
                          .snapshots(),
                      //initialData: getData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print("snapshothasdata");
                          print(uid);
                          return ListView.builder(
                              physics:
                                  const NeverScrollableScrollPhysics(), //AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: ((context, index) {
                                QueryDocumentSnapshot<Object?>?
                                    documentSnapshot =
                                    snapshot.data?.docs[index];
                                    print('index $index');
                                return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                    child: CheckboxListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        title: Text(
                                            (documentSnapshot != null)
                                                ? (documentSnapshot[
                                                    "Player Name"])
                                                : "",
                                            style: TextStyle(
                                                color:
                                                    Colors.deepPurpleAccent)),
                                        value: isChecked[index],
                                        activeColor: Colors.orangeAccent,
                                        checkColor: Colors.limeAccent,
                                        tileColor:
                                            Color.fromARGB(255, 10, 52, 87),
                                        onChanged: (bool? value) {
                                          if (value != null) {
                                            setState(() {
                                              //print(value);
                                              //print(isChecked[index]);
                                              isChecked[index] = value;
                                              //print(isChecked[index]); //}
                                            });
                                          }
                                        }));
                              }));
                        } else {
                          return Text("something is wrong",
                              style: TextStyle(color: Colors.amber));
                        }
                      }),
                  ElevatedButton(
                    clipBehavior: Clip.none,
                    child: const Text('Done Selecting Lineup'),
                    onPressed: () async {
                      getLineupList(uid, gameName).then((value) {
                        print('$lineupList');
                      }).then((value) {
                        //print('building $lineupList');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StatTrackingScreen(
                                myPlayers: lineupList, uid: uid, gameName: gameName, newPointState: newPointState,),
                          ),
                        );
                      });
                    },

                    /*await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => newLineScreen();
            },*/
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (Set<MaterialState> states) {
                        return Colors.blue;
                      }),
                    ),
                  ),
                ])),
          ));
    });
  }
}

/* for working purposes to be copy pasted when creating a new screen that needs variables to be passed in
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class newLineScreen extends StatefulWidget {
  List<String> myPlayers;
  int uid;
  const newLineScreen({Key? key, required this.myPlayers, this.uid})
      : super(key: key);

  @override
  State<newLineScreen> createState() =>
      _newLineScreenState(myPlayers: this.myPlayers, uid: this.uid);
}

class _newLineScreenState extends State<newLineScreen> {
  List<String> myPlayers;
  int uid;
  @override
  _newLineScreenState({required this.myPlayers, required this.uid});
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CheckboxListTile(
          
        ),
      ),
    );
  }
}*/
