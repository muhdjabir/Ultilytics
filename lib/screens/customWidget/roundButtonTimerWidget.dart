import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  var color;
  //final String label;
  final IconData icon;
  RoundButton({Key? key, required this.color, required this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        //shape:,
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        child: CircleAvatar(
          backgroundColor: color,
          radius: 22,
          child: Icon(
            icon,
            size: 30,
            color: Colors.white70,
          ),
        ));
  }
}