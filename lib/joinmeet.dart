import 'dart:core';
import 'dart:core';
import 'dart:io';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jitsi_meet_platform_interface/feature_flag/feature_flag_enum.dart';
//import 'package:jitsi_meeting_plus/jitsi_meet_platform_interface/feature_flag/feature_flag_enum.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'create_meet.dart';

class joinmeet extends StatefulWidget {
  const joinmeet({Key? key}) : super(key: key);

  @override
  State<joinmeet> createState() => _joinmeetState();
}

class _joinmeetState extends State<joinmeet> {
  TextEditingController _controller = TextEditingController();
  TextEditingController roomController = TextEditingController();
  String user = "";
  bool video = true;
  bool audio = true;
  bool val = false;

  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    DocumentSnapshot data = await userCollection.doc(uid).get();
    setState(() {
      user = data["Name"];
      val = true;
    });
  }

  _joinMeeting() async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;

        // Here is an example, disabling features for each platform



      var options = JitsiMeetingOptions(room: roomController.text)

        //..room = roomController.text // Required, spaces will be trimmed
        ..userDisplayName = _controller.text == "" ? user : _controller.text
        ..audioMuted = audio
        ..videoMuted = video;


      await JitsiMeet.joinMeeting(options);
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Text("Meeting Code",
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFFFFBD73),
                      fontWeight: FontWeight.w700)),
              SizedBox(
                height: 20,
              ),
              PinCodeTextField(
                controller: roomController,
                backgroundColor: Colors.white10,
                textStyle: TextStyle(color: Colors.black54, fontSize: 22),
                appContext: context,
                autoDisposeControllers: false,
                length: 6,
                onChanged: (value) {},
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                    selectedFillColor: Colors.black38,
                    activeColor: Colors.black38,
                    shape: PinCodeFieldShape.underline),
                animationDuration: Duration(microseconds: 300),
              ),
              SizedBox(
                height: 25,
              ),
              CheckboxListTile(
                value: video,
                onChanged: (value) {
                  setState(() {
                    video = value!;
                  });
                },
                title: Text("Video off",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w700)),
              ),
              SizedBox(
                height: 16,
              ),
              CheckboxListTile(
                value: audio,
                onChanged: (value) {
                  setState(() {
                    audio = value!;
                  });
                },
                title: Text("Audio Muted",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 120,
              ),

              InkWell(
                //onTap: _joinMeeting,
                child: Container(
                  width:  MediaQuery.of(context).size.width / 2,
                  height: 64,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.purple, Colors.orange]),
                  ),
                  child: Center(
                    child: Text(
                      "Join Meet",
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
        ),
      ),
    );
  }
}
