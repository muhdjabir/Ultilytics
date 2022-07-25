import 'package:flutter/material.dart';

//https://www.youtube.com/watch?v=yNN8NthQIu4 creating custom widgets
class NameWidget extends StatelessWidget {
  final String inputText;
  //const NameWidget({this.inputText = 'name'});
  NameWidget({Key? key, this.inputText = 'name'}) : super(key: key);
  var editName = 'Edit name';
  var removePlayer = 'Remove player';
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
              ],
            ),
          ),
          const SizedBox(
            height: 44.0,
          ),
        ]));
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
