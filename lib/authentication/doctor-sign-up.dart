import 'package:flutter/material.dart';
import 'package:web3dart/contracts.dart';

class Dsignup extends StatefulWidget {
  const Dsignup({Key? key}) : super(key: key);

  @override
  State<Dsignup> createState() => _DsignupState();
}

class _DsignupState extends State<Dsignup> {
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repassword = TextEditingController();
  bool x1 = false;
  bool x2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 40.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Tile2('Id', id),
                  Tile2('Name', name),
                  Tile2('Email', email),
                  Tile2('Password', password),
                  Tile2('RePassword', repassword),
                  RaisedButton(
                    onPressed: () {},
                    child: Text('SignUp'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Tile2(String s1, TextEditingController s2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(s1 + ':'),
        if (s1 == 'Password')
          Row(
            children: [
              Flexible(
                child: TextField(
                  controller: s2,
                  obscureText: x1,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    x1 = !x1;
                  });
                },
                icon: Icon(!x1 ? Icons.visibility : Icons.visibility_off),
              ),
            ],
          ),
        if (s1 == 'RePassword')
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: s2,
                  obscureText: x2,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    x2 = !x2;
                  });
                },
                icon: Icon(!x2 ? Icons.visibility : Icons.visibility_off),
              ),
            ],
          ),
        if (s1 != 'Password' && s1 != 'RePassword')
          TextField(
            controller: s2,
          ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
