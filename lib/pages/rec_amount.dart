import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emood/pages/createhabit/uploadhabit.dart';
import 'package:emood/utils/showup.dart';
import 'package:emood/utils/sign_in.dart';
import 'package:emood/utils/sizeup.dart';
import 'package:emood/widgets/cta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:vibrate/vibrate.dart';

import 'habits_overview.dart';

class RecAmount extends StatefulWidget {

  final String name;
  final int icon;

  const RecAmount({Key key, this.name, this.icon}) : super(key: key);


  @override
  _RecAmountState createState() => _RecAmountState();
}

class _RecAmountState extends State<RecAmount> {

  int amount;
  FirebaseUser userdata;

  Future createNewHabit() async{
    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: UploadHabit(icon: widget.icon, name: widget.name, amount: amount,), duration: Duration(milliseconds: 300)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: body(context),
    );
  }

  body(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 19,
          top: 109,
          child: GestureDetector(
              onTap: () {
                Vibrate.feedback(FeedbackType.light);
                Navigator.pop(context);
              },
              child: SizeUp(
                  delay: 1100,
                  child: Container(
                      width: 50,
                      height: 50,
                      child: Image.asset("assets/back.png", scale: 2)))),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 150),
              child: SizeUp(
                delay: 200,
                child: Image.asset("assets/man-middle.png", scale: 1.7),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0, left: 50, right: 50),
              child: ShowUp(
                delay: 400,
                child: Text(
                  "How often do you want to do this habit a week?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF0B0B0B),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 80),
              child: ShowUp(
                delay: 600,
                child: SleekCircularSlider(
                  min: 1.0,
                  max: 7.0,
                  initialValue: 1,
                  onChange: (double value) {
                    amount = value.round();
                  },
                  
                  appearance: CircularSliderAppearance(
                    startAngle: 180,
                    customColors: CustomSliderColors(
                      trackColor: Color(0xFFE67F7A),
                      progressBarColors: [
                        Color(0xFFE67F7A),
                        Color(0xFFF4A261),
                      ],
                      shadowColor: Color(0xFFF4A261),
                    ),
                    customWidths: CustomSliderWidths(
                      trackWidth: 4,
                      progressBarWidth: 25,
                    ),
                    infoProperties: InfoProperties(mainLabelStyle: TextStyle(color: Color(0xFFE67F7A), fontSize: 40),modifier: (value){
                      return value.round().toString();
                    }),
                    animationEnabled: false,
                    size: 200,
                    angleRange: 240
                    ),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 65),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizeUp(
              delay: 800,
              child: CTA(
                text: "make it my habit",
                voidCallback: () {
                  createNewHabit().then((_){
                    Vibrate.feedback(FeedbackType.success);
                  });
                }),
            ),
          ),
        ),
      ],
    );
  }
}
