//team select
//game details date
//time start
//opponent name
//tournament name
//comments weather/wind...
//starting on O or D

//lineup page

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class newGameScreen extends StatefulWidget {
  const newGameScreen({Key? key}) : super(key: key);

  @override
  State<newGameScreen> createState() => _newGameScreenState();
}

class _newGameScreenState extends State<newGameScreen> {
  //final Globalkey<FormState> _formkeyValue=new
  late TextEditingController controllerOpponentName;
  String _opponentName = "";
  late TextEditingController controllerTournamentName;
  late TextEditingController controllerGameDetails;
  late var myTeams = ['Team 1', 'Team 2', 'Team 3'];
  //var me = FirebaseFirestore.instance.collection('users').doc(uid);
  //late var myTeams;
  String? myTeamSelect;
  
  @override
  void initState() {
    super.initState();
    controllerOpponentName = TextEditingController();
    controllerTournamentName = TextEditingController();
    controllerGameDetails = TextEditingController();
  }

  Future getTeamDocs(String uid) async {
  QuerySnapshot <Map<String,dynamic>>querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('teams')
      .get();
  
  /*final allData =
      querySnapshot.docs.map((doc) => doc.get('Team Name')).toList();
  return allData;*/
  setState(() {
    myTeams = List.from(querySnapshot.docs.map((doc) => doc.data()['Team Name']));
  });
}

  final FirebaseAuth auth = FirebaseAuth.instance;
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(color: Colors.grey),
        ),
      );
  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    //late var myTeams;
    var teamsData = getTeamDocs(uid);
    /*(value) {
      setState(() {
        List<String> myTeams= List.from(value.data['Teams']);
      });
    });*/
    //late var myTeams = FirebaseFirestore.instance.collection('users');
    var teamsSnapshot = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('teams')
        .snapshots();
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Container(
            alignment: Alignment.centerLeft,
            child: const Text("Create New Game")),
      ),
      //elevation: 0,
      body: //Form(
          //key:_formkeyValue,
          //autovalidateMode:true,
          //child:
          ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        children: <Widget>[
          Row(
            children: [
              const Icon(
                Icons.group_sharp,
                color: Colors.grey,
                size: 40,
              ),
              SizedBox(width: 17),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream:FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .collection('teams')
                  .snapshots(),
                  builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<DropdownMenuItem> teamItems =[];
                  for(int i=0; i<snapshot.data!.docs.length;i++){
                  DocumentSnapshot snap = snapshot.data!.docs[i];
                  //print(snap.id);
                  teamItems.add(
                    DropdownMenuItem(child: Text(snap.id),value:snap.id)
                  );}
                  if (teamItems == null){
                    return const Text("Go and create a Team!!",
                      style: TextStyle(color: Colors.amber));
                      }
                  else{
                  return DropdownButton<dynamic>(
                    value: myTeamSelect,
                  hint: const Text(
                    "Select Your Team",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  //isExpanded: true,
                  style: const TextStyle(color: Colors.grey),
                  items: teamItems,
                  onChanged: (myTeamSelect) =>
                      setState(() { 
                        this.myTeamSelect = myTeamSelect;
                        
                        }),
                );
                }} else {
                  return const Text("something is wrong",
                      style: TextStyle(color: Colors.amber));
                      } },)
                /*DropdownButton<String>(
                  hint: const Text(
                    "Select Your Team",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  //isExpanded: true,
                  style: const TextStyle(color: Colors.white),
                  items: myTeams,
                  onChanged: (myTeamSelect) =>
                      setState(() => this.myTeamSelect = myTeamSelect),
                ),*/
              ),
            ],
          ),
          TextFormField(
            cursorColor: Colors.grey,
            controller: controllerOpponentName,
            style: const TextStyle(color: Colors.limeAccent),
            decoration: const InputDecoration(
              icon: Icon(
                Icons.run_circle_outlined,
                color: Colors.grey,
                size: 40,
              ),
              fillColor: const Color.fromRGBO(66, 165, 245, 1.0),
              hintText: "Enter Opponents Name",
              hintStyle: TextStyle(color: Color.fromARGB(255, 75, 75, 75)),
              labelText: "Opponents:",
              labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            onChanged: (val) {
              setState(() {
                _opponentName = val;
              });
            },
          ),
          ElevatedButton(
            child: const Text('Create Game'),
            onPressed: () async {
              print(_opponentName);
              //print(teamItems);
              print(myTeamSelect);
              /*insertTeamData(newTeamName, uid, _playerList.length);
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .collection('teams')
                      .doc(newTeamName)
                      .update({"Players": _playerList});
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(index: 3),
                    ),
                  );*/
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return Colors.blue;
              }),
            ),
          ),
        ],
      ), //),
    );
  }
}

/*{
DropdownButton(
  //isExpanded : true
  items: items.map((itemsname){
    value:itemsname,
    child: Text(itemsname)
    onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
  })
)}*/
