// ignore_for_file: avoid_single_cascade_in_expression_statements

// import 'dart:js';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/navigation_screen.dart';
import 'pages/home_screen.dart';

// @dart=2.9

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized(); //imp line need to be added first
  FlutterError.onError = (FlutterErrorDetails details) {
    //this line prints the default flutter gesture caught exception in console
    //FlutterError.dumpErrorToConsole(details);
    Flushbar(
      //title:  "Hey Ninja",
      message:  "Error, please retry",
      duration:  Duration(seconds: 3),
    )..show;
    print("Error From INSIDE FRAME_WORK");
    print("----------------------");
    print("Error :  ${details.exception}");
    print("StackTrace :  ${details.stack}");
  };
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: navigate(),
    );
  }
}

class navigate extends StatefulWidget {
  const navigate({Key? key}) : super(key: key);

  @override
  _navigateState createState() => _navigateState();
}

class _navigateState extends State<navigate> {

  int log_check=0;
  @override

  void initState()
  {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((event) {
      if(event != null) {
        setState(() {
          log_check = 1;
        });
      } else {
        setState(() {
          log_check = 0;
        });
      }
    });
  }

  Widget build(BuildContext context) {

      return Scaffold(
        body: navigation(),
      );

  }
}



