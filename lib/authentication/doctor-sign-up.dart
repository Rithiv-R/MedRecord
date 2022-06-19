import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/contracts.dart';
import 'package:image_picker/image_picker.dart';

import '../api/Firebaseapi.dart';

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
  TextEditingController privatekey = TextEditingController();
  bool x1 = true;
  bool x2 = true;
  XFile? _image;
  var url =
      "https://cdn.pixabay.com/photo/2017/06/13/12/53/profile-2398782_960_720.png";

  Future getProfile(bool cameraon) async {
    XFile image;
    final imgpicker = ImagePicker();
    if (cameraon) {
      image = (await imgpicker.pickImage(source: ImageSource.camera))!;
    } else {
      image = (await imgpicker.pickImage(source: ImageSource.gallery))!;
    }
    setState(() {
      _image = image;
    });
  }

  Future upload(var image) async {
    File s = File(image.path);
    final filename = Timestamp.now();
    final email1 = email.text;
    final destination = '/profile/$email1/$filename';
    var task = FirebaseApi.uploadFile(destination, s);
    if (task == null) {
      return;
    } else {
      final snapshot = await task.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      setState(() {
        this.url = urlDownload;
      });
      FirebaseFirestore.instance.collection('doctor').doc(email.text).set({
        'id': id.text,
        'name': name.text,
        'email': email.text,
        'key': privatekey.text,
        'password': password.text,
        'repassword': password.text,
        'profile': urlDownload,
      });
    }
  }

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
                  Tile2('Private key', privatekey),
                  Tile2('Password', password),
                  Tile2('RePassword', repassword),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 100,
                        child: ClipOval(
                          child: (_image == null)
                              ? Image(
                                  image: NetworkImage(
                                      "https://cdn.pixabay.com/photo/2017/06/13/12/53/profile-2398782_960_720.png"),
                                )
                              : Image.file(
                                  File(_image!.path),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text('Choose Profile Picture:'),
                          Row(
                            children: <Widget>[
                              IconButton(
                                  onPressed: () {
                                    getProfile(false);
                                  },
                                  icon: Icon(Icons.insert_drive_file_outlined)),
                              IconButton(
                                  onPressed: () {
                                    getProfile(true);
                                  },
                                  icon: Icon(Icons.camera_alt_outlined)),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (_image != null) {
                        upload(_image);
                      } else {
                        FirebaseFirestore.instance
                            .collection('doctor')
                            .doc(email.text)
                            .set({
                          'id': id.text,
                          'name': name.text,
                          'email': email.text,
                          'key': privatekey.text,
                          'password': password.text,
                          'repassword': password.text,
                          'profile': url,
                        });
                      }
                    },
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
