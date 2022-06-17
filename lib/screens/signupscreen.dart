import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:orbital_ultylitics/screens/ProfileScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final auth = FirebaseAuth.instance;
  CollectionReference usersCollectionRef =
      FirebaseFirestore.instance.collection('users');
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _email = '';
  String _password = '';
  //Authservices _user;
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.jpg', height: 100, width: 100),
            const Text(
              "Create new account",
              style: TextStyle(
                color: Color.fromARGB(255, 79, 149, 184),
                fontSize: 44.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 44.0,
            ),
            TextField(
              onChanged: (val) {
                setState(() => _email = val);
              },
              style: const TextStyle(color: Colors.white),
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "User Email",
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                prefixIcon: Icon(Icons.mail, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            TextFormField(
              onChanged: (val) {
                setState(() => _password = val);
              },
              style: const TextStyle(color: Colors.white),
              //controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Your Password",
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                prefixIcon: Icon(Icons.lock, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 100.0,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: const Color(0xFF0069FE),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                onPressed: () async {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                          email: _email,
                          password: _password,
                        )
                        .then((Null) => {
                              FirebaseAuth.instance
                                  .authStateChanges()
                                  .listen((User? user) async {
                                if (user != null) {
                                  print(user.uid);
                                  usersCollectionRef.doc(user.uid).set({
                                    "email": _email,
                                    "uid": user.uid
                                  }); //this works very well
                                  /*print(user.uid);
                                  usersCollectionRef
                                  .add({"email": _email, "uid": user.uid});*/ //works kinda
                                  //usersCollectionRef.doc(''+user.uid);
                                  //String id= (await usersCollectionRef.doc(ID).toString) as String;

                                }
                              }),
                            });
                  }

                  /*FirebaseAuth.instance
                        .authStateChanges()
                        .listen((User? user) {
                      if (user == null)
                        ;
                      else
                      String uid;
                        CollectionReference users =
                            FirebaseFirestore.instance.collection('users');
                      DocumentReference<Map<String, dynamic>> users =
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(uid);
                      users.set({'displayName': email, 'uid': uid});
                      ;
                    });
                  }*/
                  on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }

                  //print(user);
                  //String uid = FirebaseAuth.instance.currentUser?.uid;

                  //await _user.userSetup(_emailController.text,);
                  //await users.add({'name': _email, });
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ProfileScreen(index: 2)));
                },
                child: const Text(
                  "Sign-up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
