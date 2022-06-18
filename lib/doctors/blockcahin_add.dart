import 'package:flutter/material.dart';

class Blockadder extends StatefulWidget {
  const Blockadder({Key? key}) : super(key: key);

  @override
  State<Blockadder> createState() => _BlockadderState();
}

class _BlockadderState extends State<Blockadder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BlockAdder'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Tile('Patient Name', 'Ritish.S'),
              Tile('Patient Email', 'ivrith07@gmail.com'),
              Tile('Doctor Id', '10375'),
              Tile('Doctor Name', 'Rithiv.R'),
              Tile('Doctor Email', 'rithiv07@gmai.com'),
              Tile('Record Hash', 'AM7OBiLuWYe38I3rFHX8'),
            ],
          ),
        ));
  }
}

Widget Tile(String s1, String s2) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(s1 + ':'),
          Padding(padding: EdgeInsets.only(left: 10)),
          Text(s2),
        ],
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}
