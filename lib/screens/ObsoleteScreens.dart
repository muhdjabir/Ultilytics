/*class GameSummaryScreen extends StatelessWidget {
  final Game game;
  final String docID;

  Stream<QuerySnapshot> getPlayerStats() {
    FirebaseAuth auth = FirebaseAuth.instance;
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

  const GameSummaryScreen({
    Key? key,
    required this.game,
    required this.docID,
  }) : super(key: key);

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
          title: Text("${game.teamName} vs ${game.opponentName}"),
        ),
        body: Column(children: <Widget>[
          Text(
            "${game.myScore} - ${game.opponentScore}",
            textAlign: TextAlign.center,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text("Name",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            Text("Scores",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            Text("Assists",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            Text("Throwaways",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)))
          ]),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: players,
                  builder: (context, snapshot) {
                    if (snapshot.hasData || snapshot.data != null) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            QueryDocumentSnapshot<Object?>? documentSnapshot =
                                snapshot.data?.docs[index];
                            Player player =
                                Player.fromSnapshot(documentSnapshot);
                            return Card(
                              /*elevation: 4,
                                child: Row(
                                  children: [
                                    Text(player.name.toString()),
                                    Text(player.assists.toString()),
                                    Text(player.catches.toString())
                                  ],*/
                              child: ListTile(
                                  tileColor: Color.fromARGB(255, 10, 52, 87),
                                  textColor: Colors.deepPurpleAccent,
                                  title: Text(player.name.toString()),
                                  onTap: () => print("HI")),
                            );
                          });
                    } else {
                      return Text("No Players");
                    }
                  }))
        ]));
  }
}
*/