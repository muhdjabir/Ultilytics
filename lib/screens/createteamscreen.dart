//add players
//show list of players
//store data of each player
//dropdown menu

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:orbital_ultylitics/namewidget.dart';
import 'package:orbital_ultylitics/screens/settingscreen.dart';

import 'profileScreen.dart';

class CreateTeamScreen extends StatefulWidget {
  const CreateTeamScreen({Key? key}) : super(key: key);

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

Future<void> insertData(final player) async {
  CollectionReference usersCollectionRef =
      FirebaseFirestore.instance.collection('users');
}

enum Menu { removePlayer, editName }

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  //PlayersRecord playerName;
  late TextEditingController newPlayerName;
  late TextEditingController newTeamName;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  //String removeName = 'Remove Name', editName = 'Edit Name';
  //enum Menu {removeName, editName}
  String _selectedMenu = '';
  @override
  void initState() {
    super.initState();
    newTeamName = TextEditingController();
    newPlayerName = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black45,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 100,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 4, 36, 52),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(
                              fontSize: 20.0,
                              color: Color.fromARGB(255, 110, 148, 252),
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                          controller: newTeamName,
                          /*onChanged: (_) => EasyDebounce.debounce(
                            'newTeamName',
                            Duration(milliseconds: 2000),
                            () => setState(() {}),
                          ),*/
                          autofocus: true,
                          obscureText: false,
                          decoration: const InputDecoration(
                            hintText: 'Insert New Team Name',
                            hintStyle: TextStyle(
                                fontSize: 20.0,
                                color: Color.fromARGB(255, 56, 75, 128),
                                fontWeight: FontWeight.w700),
                            /*enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(0, 233, 236, 240),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),*/
                          ),
                          /*style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),*/
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                        child: Container(
                          color: Colors.grey[700],
                          child: const Text(
                            'Player name 1',
                            style: TextStyle(
                                fontSize: 40.0,
                                color: Color.fromARGB(255, 29, 132, 192),
                                fontWeight: FontWeight.w500),
                            /*style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Poppins',
                                  color:
                                      FlutterFlowTheme.of(context).secondaryText,
                                ),*/
                          ),
                        ),
                      ),
                      PopupMenuButton<Menu>(
                        color: const Color.fromARGB(255, 212, 212, 212),
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(80, 0, 0, 0),
                        icon: const Icon(
                          Icons.more_vert,
                          color: Color.fromARGB(255, 66, 66, 66),
                          size: 30,
                        ),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<Menu>>[
                          const PopupMenuItem<Menu>(
                            value: Menu.removePlayer,
                            child: Text('Remove Player'),
                          ),
                          const PopupMenuItem<Menu>(
                            value: Menu.editName,
                            child: Text('Edit Name'),
                          ),
                        ],
                        onSelected: (Menu item) {
                          setState(
                            () {
                              _selectedMenu = item.name;
                              if (_selectedMenu == 'removePlayer') {}
                              if (_selectedMenu == 'editName') {}
                            },
                          );
                        },
                        /*onSelected: (Menu item){
                          setState((){
                            //insert function to do depending on newValue received upon selection
                            if(newValue == removeName){

                            }
                            if(newValue == editName){

                            }
                          });
                        },*/
                      ),
                      /*IconButton(
                        alignment: Alignment(13.5, 0.0),
                        color: Color.fromARGB(255, 212, 212, 212),
                        splashRadius: 30,
                        //padding = const EdgeInsets.all(1.0),
                        iconSize: 40,
                        icon: const Icon(
                          Icons.more_vert,
                          //color: FlutterFlowTheme.of(context).secondaryText,
                          size: 30,
                        ),
                        //color: Colors.amber,
                        onPressed: () {
                          print('vertical dots menu pressed');
                        },
                      ),*/
                      /*Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(200, 0, 0, 0),
                          child: IconButton(
                            color: Color.fromARGB(0, 175, 113, 113),
                            splashRadius: 30,
                            //padding = const EdgeInsets.all(1.0),
                            iconSize: 40,
                            icon: const Icon(
                              Icons.more_vert,
                              //color: FlutterFlowTheme.of(context).secondaryText,
                              size: 30,
                            ),
                            onPressed: () {
                              print('vertical dots menu pressed');
                            },
                          ),
                        ),
                      ),*/
                    ],
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[400],
                  //decoration: ,
                  /*decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                  ),*/
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 20.0,
                                color: Color.fromARGB(255, 92, 123, 207),
                                fontWeight: FontWeight.w500),
                            controller: newPlayerName,
                            /*onChanged: (_) => EasyDebounce.debounce(
                              'newPlayerName',
                              Duration(milliseconds: 2000),
                              () => setState(() {}),
                            ),*/
                            autofocus: true,
                            obscureText: false,
                            decoration: const InputDecoration(
                              hintText: 'Input name of new player',
                              hintStyle: TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromARGB(255, 56, 75, 128),
                                  fontWeight: FontWeight.w500),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                            ),
                            /*style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),*/
                          ),
                        ),
                      ),
                      IconButton(
                        color: Color.fromARGB(0, 198, 113, 113),
                        splashRadius: 30,
                        //borderWidth: 1,
                        iconSize: 40,
                        icon: const Icon(
                          Icons.add_box_outlined,
                          color: Color.fromARGB(255, 66, 66, 66), //FlutterFlowTheme.of(context).secondaryText,
                          size: 30,
                        ),
                        onPressed: () async {
                          /*final playersCreateData = createPlayersRecordData();
                          var playersRecordReference =
                              PlayersRecord.collection.doc();
                          await playersRecordReference.set(playersCreateData);
                          playerName = PlayersRecord.getDocumentFromData(
                              playersCreateData, playersRecordReference);

                          setState(() {});*/
                        },
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  child: Text('Create Team'),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(index: 3),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                      return Colors.blue;
                    }),
                  ),
                  /*options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    color: FlutterFlowTheme.of(context).primaryColor,
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 12,*/
                  //),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*class _CreateTeamScreenState extends State<CreateTeamScreen> {
  var names = ['Linus', 'Jabir', 'Ryan', 'Bolte', 'Cat', 'Cheryl', 'Jo'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height:250,
            child: Wrap(
              direction: Axis.vertical,
              children: (
                child: ListView(
                  children: List.generate(
                /*length*/ names.length,
                (index) {
                  return NameWidget(inputText: names[index]);
                },
              ),)),
            ),
          )
        ],
      ),
    );
  }
}*/
