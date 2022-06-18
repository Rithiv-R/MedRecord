import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transition/transition.dart';

class Recordadd extends StatefulWidget {
  const Recordadd({Key? key}) : super(key: key);

  @override
  State<Recordadd> createState() => _RecordaddState();
}

class _RecordaddState extends State<Recordadd> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();
  TextEditingController t5 = TextEditingController();
  TextEditingController t6 = TextEditingController();
  TextEditingController t7 = TextEditingController();
  TextEditingController t8 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Record Add'),
        centerTitle: true,
      ),
      body: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Car Service Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        inputFile1(label: "Circulatory Sys", controller: t1),
                        SizedBox(
                          height: 15,
                        ),
                        inputFile1(label: "Respiratory Sys", controller: t2),
                        SizedBox(
                          height: 15,
                        ),
                        inputFile1(label: "Digestive Sys", controller: t3),
                        SizedBox(
                          height: 15,
                        ),
                        inputFile1(label: "Skeletal Sys", controller: t4),
                        SizedBox(
                          height: 15,
                        ),
                        inputFile1(label: "Muscular Sys", controller: t5),
                        SizedBox(
                          height: 15,
                        ),
                        inputFile1(label: "Nervour Sys", controller: t6),
                        SizedBox(
                          height: 15,
                        ),
                        inputFile1(label: "Reproductive Sys", controller: t7),
                        SizedBox(
                          height: 15,
                        ),
                        inputFile(label: "Additional Details", controller: t8),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    FirebaseFirestore.instance.collection('Records').add({
                      'Circulatory': t1.text,
                      'Respiratory': t2.text,
                      'Digestive': t3.text,
                      'Skeletal': t4.text,
                      'Muscular': t5.text,
                      'Nervous': t6.text,
                      'Reproductive': t7.text,
                      'Additional': t8.text,
                    }).then((docref) {
                      FirebaseFirestore.instance
                          .collection('Records')
                          .doc(docref.id)
                          .update({
                        'id': docref.id,
                      }).then((value) {
                        Navigator.push(
                            context,
                            Transition(
                                child: Recordadd(),
                                transitionEffect:
                                    TransitionEffect.LEFT_TO_RIGHT));
                      });
                    });
                  },
                  color: Colors.indigoAccent,
                  splashColor: Colors.blue,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Submit Details",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget inputFile1({label, obscureText = false, controller}) {
  return Row(
    children: <Widget>[
      Container(
        width: 130,
        child: Text(label,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87)),
      ),
      SizedBox(
        width: 30,
      ),
      Container(
        width: 150,
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
      ),
    ],
  );
}

Widget inputFile({label, obscureText = false, controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(
        height: 10,
      ),
      TextField(
        controller: controller,
        maxLines: 3,
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      ),
      SizedBox(
        height: 10,
      )
    ],
  );
}
