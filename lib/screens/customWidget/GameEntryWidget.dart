import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/screens/TeamEntries/CreateTeamScreen.dart';

class GameEntryWidget extends StatelessWidget {
  const GameEntryWidget({Key? key, required this.child}) : super(key: key);
  final String child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 10, 52, 87),
        ),
        child: Row(
          children: [
            Container(
              width: 220,
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(child,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.deepPurpleAccent,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 0, 20, 10),
              child: IconButton(
                icon: const Icon(
                  Icons.keyboard_arrow_right_sharp,
                  //color:,
                  size: 40,
                ),
                onPressed:
                    () {} /*() async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CreateTeamScreen(newTeamName: child),
                    ),
                  );
                }*/
                ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
