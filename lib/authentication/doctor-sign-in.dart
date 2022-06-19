import 'package:flutter/material.dart';

class Dsignin extends StatefulWidget {
  const Dsignin({Key? key}) : super(key: key);

  @override
  State<Dsignin> createState() => _DsigninState();
}

class _DsigninState extends State<Dsignin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Tile1('Email:', email),
              Tile1('Password:', password),
              RaisedButton(
                onPressed: () {},
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget Tile1(String s1, TextEditingController s2) {
  return Padding(
    padding: const EdgeInsets.only(left: 40, right: 40),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(s1),
        TextField(
          controller: s2,
        ),
        SizedBox(
          height: 20,
        )
      ],
    ),
  );
}
