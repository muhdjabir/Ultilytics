import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:orbital_ultylitics/screens/NavigationBarScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
              key: ValueKey("emailField"),
              //Creating User Email field box
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
              key: ValueKey("passwordField"),
              // Creating Password textbox
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
              height: 12.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                  key: ValueKey("backButton"),
                  child: const Text(
                    "Back to Login",
                    textAlign: TextAlign.left,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            const SizedBox(
              height: 75.0,
            ),
            Container(
              key: ValueKey("signUpButton"),
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: const Color(0xFF0069FE),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                onPressed: () async {
                  // Takes in textbox inputs to attempt sign up
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
                                final auth = FirebaseAuth.instance;
                                CollectionReference usersCollectionRef =
                                    FirebaseFirestore.instance
                                        .collection('users');
                                if (user != null) {
                                  usersCollectionRef
                                      .doc(user.uid)
                                      .set({"email": _email, "uid": user.uid});
                                }
                              }),
                            });
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => NavigationBarScreen(index: 2)));
                  } on FirebaseAuthException catch (e) {
                    // Alerts the user regarding failed registration
                    if (e.code == 'weak-password') {
                      errorMessage('Password is too weak');
                    } else if (e.code == 'email-already-in-use') {
                      errorMessage('Email is already registered');
                    }
                  } catch (e) {
                    print(e);
                  }
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

  Future errorMessage(String error) => showDialog(
      context: context,
      builder: (context) => AlertDialog(title: Text('${error}'), actions: [
            TextButton(
              child: Text('Okay'),
              onPressed: okay,
            )
          ]));

  void okay() {
    Navigator.of(context).pop();
  }
}
