import 'package:flutter/material.dart';
import 'package:exam2/widgets/sub_tile.dart';

class Tile extends StatelessWidget {
  List<String> title = [];
  List<String> value = [];

  Tile({this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SubTile(title: '${title[0]}', value: '${value[0]}'),
        SubTile(title: '${title[1]}', value: '${value[1]}'),
      ],
    );
  }
}
