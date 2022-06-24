import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../doctors/record_add.dart';

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
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('adoc')
                      .doc(email.text.trim())
                      .get()
                      .then((DocumentSnapshot snapshot) async {
                    if (snapshot.exists) {
                      try {
                        await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email.text.trim(),
                                password: password.text.trim())
                            .then((_) =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Recordadd(
                                          email: this.email.text.trim(),
                                        ))));
                      } on FirebaseAuthException catch (e) {
                        print('Error');
                      }
                    }
                  });
                },
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
