import 'package:emood/pages/habits_overview.dart';
import 'package:emood/utils/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  void initState(){
    super.initState();
    getUser().then((user){
      if(user != null){
        goToHabits(user);
      }else{
        goToLogin();  
      }
    });
  }

  Future goToHabits(FirebaseUser user) async{
    await Future.delayed(const Duration(milliseconds: 1500));
    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: HabitsOverview(user: user), duration: Duration(milliseconds: 300)));
  }

  Future goToLogin() async{
    await Future.delayed(const Duration(milliseconds: 1500));
    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Login(), duration: Duration(milliseconds: 300)));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFFAFAFA),
        child: Center(
          child: Image.asset("assets/logo_splash.png"),
        ),
      ),
    );
  }
}