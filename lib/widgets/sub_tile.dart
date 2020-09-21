import 'package:flutter/material.dart';

class SubTile extends StatelessWidget {
  String title;
  String value;

  SubTile({this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '$title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromRGBO(35, 49, 95, 1),
              ),
            ),
            SizedBox(width: 8),
            Text(
              '$value',
              style: TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(35, 49, 95, 0.8),
              ),
            ),
          ],
        )
      ],
    );
  }
}
