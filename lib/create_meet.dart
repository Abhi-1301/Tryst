import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

CollectionReference userCollection =
    FirebaseFirestore.instance.collection("users");

class createmeet extends StatefulWidget {
  const createmeet({Key? key}) : super(key: key);

  @override
  State<createmeet> createState() => _createmeetState();
}

class _createmeetState extends State<createmeet> {
  TextEditingController text_controller = TextEditingController();
  String s = "";
  bool f = false;

  generate() {
    setState(() {
      s = Uuid().v1().substring(0, 6);
      f = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: Colors.white,
      key: key,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              "Create a code for a meeting!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFFFBD73),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Code: ", style: TextStyle(color: Colors.black45)),
              GestureDetector(
                child: Text(
                  s,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black38,
                      fontWeight: FontWeight.w700),
                ),
                onLongPress: () {
                  Clipboard.setData(new ClipboardData(text: s));
                  key.currentState!.showSnackBar(new SnackBar(
                    content: new Text("Meet Code Copied to Clipboard"),
                  ));
                },
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: generate,
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.purple, Colors.orange])),
              child: Center(
                child: Text(
                  "Create Code",
                  style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
