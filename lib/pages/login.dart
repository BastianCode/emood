import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emood/utils/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vibrate/vibrate.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseUser user;

  checkIfNewUser() async {
    user = await getUser();
    DocumentSnapshot ds =
        await Firestore.instance.collection("user").document(user.uid).get();
    bool temp = false;
    this.setState(() {
      temp = ds.exists;
    });
    return temp;
  }

  createUserInFirestore() async {
    await Firestore.instance.collection('user').document(user.uid).setData({});
    print("done");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
          color: Color(0xFFFAFAFA),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 220),
                child: Image.asset("assets/bigman.png", scale: 1.2),
              ),
              Padding(
                padding: EdgeInsets.only(top: 150),
                child: GestureDetector(
                  onTap: () {
                    Vibrate.feedback(FeedbackType.medium);
                    signInWithGoogle().whenComplete(() {
                    checkIfNewUser().then((exists) {
                      print(exists);
                      if (exists == false) {
                        createUserInFirestore();
                      }
                    });
                  });
                  },
                  child: Image.asset(
                    "assets/google.png",
                    scale: 0.8,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
