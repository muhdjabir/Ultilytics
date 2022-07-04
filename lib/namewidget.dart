import 'package:flutter/material.dart';

//https://www.youtube.com/watch?v=yNN8NthQIu4 creating custom widgets
class NameWidget extends StatelessWidget {
  final String inputText;
  //const NameWidget({this.inputText = 'name'});
  NameWidget({Key? key, this.inputText = 'name'}) : super(key: key);
  var editName = 'Edit name';
  var removePlayer = 'Remove player';
  //List<String> items = ['Edit name', 'Remove player'];
  //String? selectedItem = '';
  //var names = ['Linus', 'Jabir', 'Ryan', 'Bolte', 'Cat', 'Cheryl', 'Jo'];
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  inputText,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 79, 149, 184),
                    fontSize: 44.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PopupMenuButton(
                  //https://www.youtube.com/watch?v=J9XKI4RucY8
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: editName,
                      child: Text(editName),
                    ),
                    PopupMenuItem(
                      value: removePlayer,
                      child: Text(removePlayer),
                    ),
                  ],
                ),
                /*onSelected: (/*input to the button from value*/String newValue){
                      setState((){
                        //do something
                      });
                    },*/
              ],
              /*fillColor: const Color(0xFF0069FE),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              //onPressed: () async {
                
                /*User? user = await loginUsingEmailPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                    context: context);
                print(user);
                if (user != null) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const ProfileScreen(index: 0)));
                }
              }*/
              child: const Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),*/
            ),
          ),
          const SizedBox(
            height: 44.0,
          ),
        ]));
    /*Column(
      mainAxisSize: MainAxisSize.max,
    children: List.generate(7, (index){
      return Null;
    },)),
    );*/ //line 184
    /*Container(
      Column(
        Container(
          Column(
            Text title,
            Row subtitle,
            text title)
          Column(
            Container(Row(Text), Row(Icon()))
          )
        )
      )
    )
  }*/
  }
}

listplayers() {
  var names = ['Linus', 'Jabir', 'Ryan', 'Bolte', 'Cat', 'Cheryl', 'Jo'];
  return Wrap(
    direction: Axis.vertical,
    children: List.generate(/*length*/ names.length, (index) {
      return NameWidget(inputText: names[index]);
    }),
  );
}
