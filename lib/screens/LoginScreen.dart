//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:orbital_ultylitics/main.dart';
import 'package:orbital_ultylitics/screens/SignupScreen.dart';
import 'package:orbital_ultylitics/screens/NavigationBarScreen.dart';
//import '../authservices.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

ThemeData _lightTheme = ThemeData(
  //brightness: Brightness.light,
  primaryColor: const Color.fromARGB(255, 36, 101, 155),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: const Color.fromARGB(255, 3, 188, 244)),
  buttonTheme:
      const ButtonThemeData(buttonColor: Color.fromARGB(255, 36, 101, 155)),
);

ThemeData _darkTheme = ThemeData(
  //textTheme: ,
  //brightness: Colors.blue,
  primaryColor: const Color.fromARGB(255, 36, 101, 155),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: const Color.fromARGB(255, 3, 188, 244)),
  buttonTheme:
      const ButtonThemeData(buttonColor: Color.fromARGB(255, 36, 101, 155)),
);

//ool _light = true; //https://www.youtube.com/watch?v=aFei1SwczS4

//class DarkLightTheme extends
class _LoginScreenState extends State<LoginScreen> {
  //login function
  Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      // User Authentication
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        errorMessage("User not registered");
      } else if (e.code == "wrong-password") {
        errorMessage("Incorrect password");
      } else {
        print(e.code);
      }
    }

    return user;
  }

  Future errorMessage(String error) => showDialog(
      // Creates a popup alert when login fails
      context: context,
      builder: (context) => AlertDialog(
              key: ValueKey("errorMessage"),
              title: Text('${error}'),
              actions: [
                TextButton(
                  child: const Text('Okay'),
                  onPressed: okay,
                )
              ]));

  void okay() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    //create the textfiled controller
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return MaterialApp(
      //theme: _light ? _lightTheme: _darkTheme,
      home: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.jpg', height: 100, width: 100),
            const Text(
              "Become the ultimate athlete",
              style: TextStyle(
                inherit: false,
                color: Color.fromARGB(255, 79, 149, 184),
                fontSize: 44.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              //Colors: Color.white,
              height: 44.0,
            ),
            TextField(
              //Creating the Textfields for the input of Email and Password
              key: ValueKey("emailField"),
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
            TextField(
              key: ValueKey("passwordField"),
              style: const TextStyle(color: Colors.white),
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "User Password",
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
                  key: ValueKey("register"),
                  child: const Text(
                    "Create new account!",
                    textAlign: TextAlign.left,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupScreen()),
                    );
                  }),
            ),
            const SizedBox(
              height: 75.0,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                key: ValueKey("loginButton"),
                fillColor: const Color(0xFF0069FE),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                onPressed: () async {
                  //testing the app
                  User? user = await loginUsingEmailPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                      context: context);
                  //print(user);
                  if (user != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            const NavigationBarScreen(index: 0)));
                  }
                },
                child: const Text(
                  "Login",
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
