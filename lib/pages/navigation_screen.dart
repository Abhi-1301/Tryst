import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'meeting.dart';
import 'signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

CollectionReference user = FirebaseFirestore.instance.collection("users");

class navigation extends StatefulWidget {
  const navigation({Key? key}) : super(key: key);

  @override
  _navigationState createState() => _navigationState();
}

class _navigationState extends State<navigation> {
  String mail = "";
  String pwd = "";
  String err = "";

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/grp1.png"),
                      alignment: Alignment.bottomCenter,
                    ),
                  )),
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
                        Text("SIGN IN",
                            style: TextStyle(
                              color: Color(0xFFFFBD73),
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            )),
                        FlatButton(
                          color: Colors.black12,
                          textColor: Colors.white,
                          child: Text('Sign Up',
                              style: TextStyle(
                                color: Color(0xFFFFBD73),
                                fontWeight: FontWeight.bold,
                              )),
                          onPressed: () {
                            print('Pressed SignUP!');
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return SIGNUP();
                              }),
                            );
                          },
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Row(
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
                            child: TextFormField(
                              obscureText: false,
                              onChanged: (val) {
                                mail = val;
                              },
                              decoration: InputDecoration(
                                hintText: "Email address",
                              ),
                              key: ValueKey('email'),
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              enableSuggestions: false,
                              validator: (mail) {
                                if (mail == Null || !mail!.contains('@')) {
                                  return 'Please enter a valid email address.';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                          child: TextFormField(
                            obscureText: true,
                            onChanged: (val) {
                              pwd = val;
                            },
                            decoration: InputDecoration(
                              hintText: "Password",
                            ),
                            key: ValueKey('password'),
                            validator: (pwd) {
                              if (pwd == "" || pwd!.length < 7) {
                                return 'Password must be at least 7 characters long.';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      child: Container(
                        color: Color(0xFFFFBD73),
                        margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
                        width: double.infinity,
                        height: 80.0,
                        child: Center(
                          child: Text(
                            'LogIn',
                            style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {


                        var errorMessage;
                        final _auth = FirebaseAuth.instance;

                        try{
                          UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                              email: mail,
                              password: pwd,);
                          print("LOGIN");
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return login();
                            }),
                          );
                        }
                        on FirebaseAuthException catch(err)
                        {
                          Flushbar(
                            //title:  "Hey Ninja",
                            message:  err.toString(),
                            duration:  Duration(seconds: 3),
                          )..show(context);
                          var message = 'An error occurred, please check your credentials!';
                          print(message);
                          if (err.toString() != null) {
                            message = err.toString();
                            setState(() {
                              errorMessage = message;
                            });
                            print(message);
                          }
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
