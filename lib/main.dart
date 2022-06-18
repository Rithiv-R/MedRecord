import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medicalrecord/doctors/blockcahin_add.dart';
import 'package:medicalrecord/doctors/record_add.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyMain());
}

class MyMain extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Med_Recorder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home: Blockadder(),
    );
  }
}
