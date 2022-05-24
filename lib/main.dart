import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:orbital_ultylitics/profilescreen.dart';
//import 'firebase_options.dart'; // generated via `flutterfire` CLI

Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //initialise firebase app
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginScreen();
          }
          return const Center(child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}











class _LoginScreenState extends State<LoginScreen> {

  //login function
  static Future<User?> loginUsingEmailPassword(
    {required String email, 
    required String password, 
    required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e){
      if (e.code == "user-not-found"){
        print("No User found for that email");
      }
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    //create the textfiled controller
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
            Image.asset('assets/images/logo.jpg', height: 100, width: 100),
        /*const Text(
          "Ultylytics",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),*/
        const Text(
          "Become the ultimate athlete",
          style: TextStyle(
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
          style: const TextStyle(color: Colors.white),
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: "User Email",
            hintStyle: TextStyle(color: Colors.white),
            focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                   ),  
            //labelStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.mail, color: Colors.white),
          ),
        ),
        const SizedBox(
          height:26.0,
        ),
        TextField(
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
        const Text(
          "Don't remember your password?", 
          style: TextStyle(color: Colors.blue),
        ),
        const SizedBox(
          height: 88.0,
        ),
        Container(
          width: double.infinity,
          child: RawMaterialButton(
            fillColor:const Color(0xFF0069FE),
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(vertical:20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)),
            onPressed: () async {
              //testing the app
              User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
            print(user);
            if (user != null){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ProfileScreen()));
            }
            }, 
            child: const Text(
              "Login", 
              style: TextStyle(
                color:Colors.white, 
                fontSize: 18.0,
                ),
                ),
            ),
        )
      ],
    ),
  );
  }
}
