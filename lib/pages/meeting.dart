import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../create_meet.dart';
import '../joinmeet.dart';

CollectionReference user = FirebaseFirestore.instance.collection("users");

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> with SingleTickerProviderStateMixin {
  late TabController tabController;

  tabBuilder(String name) {
    return Container(
      width: 150,
      height: 50,
      child: Card(
        color: Color(0xFFFFBD73),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tryst",
          style: TextStyle(
            color: Color(0xFFFFBD73),
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: tabController,
          tabs: [
            tabBuilder("Join Meeting"),
            tabBuilder("Create Meeting"),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          joinmeet(),
          createmeet(),
        ],
      ),
    );
  }
}
