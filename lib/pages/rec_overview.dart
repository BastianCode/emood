import 'package:emood/pages/rec_amount.dart';
import 'package:emood/pages/recommeded_habits.dart';
import 'package:emood/utils/showup.dart';
import 'package:emood/utils/sign_in.dart';
import 'package:emood/utils/sizeup.dart';
import 'package:emood/widgets/cta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vibrate/vibrate.dart';

class RecOverview extends StatefulWidget {
  final String image;
  final String name;
  final String description;
  final int index;
  final int icon;

  const RecOverview(
      {Key key, this.image, this.name, this.description, this.index, this.icon})
      : super(key: key);

  @override
  _RecOverviewState createState() => _RecOverviewState();
}

class _RecOverviewState extends State<RecOverview> {
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
                  delay: 1000,
                  child: Container(
                      width: 50,
                      height: 50,
                      child: Image.asset("assets/back.png", scale: 2)))),
        ),
        Positioned(
          right: -50,
          top: -50,
          child: Hero(
            tag: "lanImage" + widget.index.toString(),
            child:
                Image.asset("assets/" + widget.image + "rou.png", scale: 1.87),
          ),
        ),
        Positioned(
          top: 280,
          left: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ShowUp(
                delay: 800,
                child: Text(
                  widget.name.toUpperCase(),
                  style: TextStyle(
                      fontSize: 25,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0B0B0B)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40, left: 30, right: 30),
                child: ShowUp(
                  delay: 1000,
                  child: Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Color(0xFF0B0B0B)),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 65),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizeUp(
              delay: 1200,
                child: CTA(
                text: "make it my habit",
                voidCallback: () {
                  Vibrate.feedback(FeedbackType.medium);
                  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: RecAmount(name: widget.name, icon: widget.icon,), duration: Duration(milliseconds: 300)));
                }
              ),
            ),
          ),
        )
      ],
    );
  }
}
