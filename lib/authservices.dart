import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(String displayName) async {
  //final FirebaseAuth auth = FirebaseAuth.instance;
  //String uid = auth.currentUser!.uid.toString();
  var currentUser = FirebaseAuth.instance.currentUser;
  String uid = currentUser!.uid;
  DocumentReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection("users").doc(uid);
  users.set({'displayName': displayName, 'uid': uid});
  return;
}

//https://www.youtube.com/watch?v=v3sY3RWciNw
Future signOut() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //var currentUser = FirebaseAuth.instance.currentUser;
  //String uid = _auth!.uid;
  try {
    return await _auth.signOut();
  } catch (e) {
    print(e.toString());
    return null;
  }
}
