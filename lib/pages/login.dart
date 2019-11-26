import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emood/pages/habits_overview.dart';
import 'package:emood/utils/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vibrate/vibrate.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseUser user;
  String nickname;

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

  dialog() {
    return CupertinoAlertDialog(
      title: Text("What do your friends call you?"),
      content: CupertinoTextField(),
    );
  }

  createUserInFirestore() async {
    await Firestore.instance.collection('user').document(user.uid).setData({
      "name": nickname
    });
    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: HabitsOverview(user: user), duration: Duration(milliseconds: 300)));
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
                        if (exists == false) {
                          showDialog<bool>(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text('What do your friends call you?'),
                                content: Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: CupertinoTextField(
                                    placeholder: "My name is...",
                                    onChanged: (text){
                                      nickname = text;
                                    },
                                  ),
                                ),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    isDefaultAction: true,
                                    child: Text("Okay"),
                                    onPressed: (){
                                      Navigator.pop(context);

                                    },
                                  )
                                ],
                              );
                            },
                          ).then((_) {
                            createUserInFirestore();
                          });
                        }else{
                          Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: HabitsOverview(user: user), duration: Duration(milliseconds: 300)));
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
