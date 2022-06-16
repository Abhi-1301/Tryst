import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tryst/pages/meeting.dart';

import 'navigation_screen.dart';

class SIGNUP extends StatefulWidget {
  const SIGNUP({Key? key}) : super(key: key);

  @override
  _SIGNUPState createState() => _SIGNUPState();
}

class _SIGNUPState extends State<SIGNUP> {
  String mail = "";
  String name = "";
  String no = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String pwd = "";

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (FlutterErrorDetails details) {
      //this line prints the default flutter gesture caught exception in console
      //FlutterError.dumpErrorToConsole(details);
      print("Error From INSIDE FRAME_WORK");
      print("----------------------");
      print("Error :  ${details.exception}");
      print("StackTrace :  ${details.stack}");
    };
    return Scaffold(
      body: Scaffold(
        body: Column(
          children: <Widget>[
            SafeArea(
              child: Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/grp1.png"),
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("SIGN UP",
                            style: TextStyle(
                              color: Color(0xFFFFBD73),
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.person,
                            color: Color(0xFFFFBD73),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (val) {
                              name = val;
                            },
                            decoration: InputDecoration(
                              hintText: "Name",
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.phone,
                            color: Color(0xFFFFBD73),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (val) {
                              no = val;
                            },
                            decoration: InputDecoration(
                              hintText: "Contact Number",
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.alternate_email,
                            color: Color(0xFFFFBD73),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (val) {
                              mail = val;
                            },
                            decoration: InputDecoration(
                              hintText: "Email-Address",
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.lock,
                            color: Color(0xFFFFBD73),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              pwd = value;
                            },
                            decoration: InputDecoration(
                              hintText: "Password",
                            ),
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      child: Container(
                        color: Color(0xFFFFBD73),
                        margin: EdgeInsets.only(top: 10.0,bottom:10.0),
                        width: double.infinity,
                        height: 80.0,
                        child: Center(
                          child: Text('Sign Up',
                              style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        UserCredential user = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: mail, password: pwd);

                        var errorMessage;
                        final _auth = FirebaseAuth.instance;

                        try{

                          await FirebaseFirestore.instance.collection('Users').doc(mail).set({
                            'Name':name,
                            'MobileNumber':no,
                            'Email':mail,
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return login();
                            }),
                          );
                        }
                        on Exception catch(err)
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return login();
                            }),
                          );
                        }


                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
