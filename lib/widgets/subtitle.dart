import 'package:flutter/material.dart';

class SubTitle extends StatelessWidget {
  String name;
  String value;

  SubTitle({this.name, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$name',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(height: 5),
        Text(
          '$value',
          style: TextStyle(color: Colors.grey[300], fontSize: 20),
        ),
      ],
    );
  }
}
