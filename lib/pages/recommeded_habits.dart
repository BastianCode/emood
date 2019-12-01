import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emood/pages/createhabit/create_habit.dart';
import 'package:emood/utils/habit_item.dart';
import 'package:emood/utils/navbar.dart';
import 'package:emood/utils/recommended_item.dart';
import 'package:emood/utils/showup.dart';
import 'package:emood/utils/sizeup.dart';
import 'package:emood/widgets/cta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vibrate/vibrate.dart';

class RecommendedHabit extends StatefulWidget {
  final FirebaseUser user;

  const RecommendedHabit({Key key, this.user}) : super(key: key);

  @override
  _RecommendedHabitState createState() => _RecommendedHabitState();
}

class _RecommendedHabitState extends State<RecommendedHabit> {
  bool listVisible;

  @override
  void initState() {
    super.initState();
    listVisible = false;
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        listVisible = true;
      });
    });
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
          top: 0,
          left: 0,
          bottom: 0,
          child: Container(
            width: 95,
            color: Color(0xFFF3F3F4),
          ),
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 19, right: 10, top: 100),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Vibrate.feedback(FeedbackType.light);
                      Navigator.pop(context);
                    },
                    child: SizeUp(
                        delay: 1000,
                        child: Container(
                            width: 50,
                            height: 50,
                            child: Image.asset("assets/back.png", scale: 2))),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 50, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ShowUp(
                          delay: 400,
                          child: Text(
                            "Recommended",
                            style: TextStyle(
                                fontSize: 35,
                                height: 0.7,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0B0B0B)),
                          ),
                        ),
                        Opacity(
                          opacity: 0.37,
                          child: ShowUp(
                            delay: 600,
                            child: Text(
                              "Get some inspiration",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF0B0B0B)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            listVisible == true
                ? Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 35, bottom: 20),
                      child: StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection('recommended_routines')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text("ERROR while loading!");
                            }
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Container();
                                break;
                              default:
                                return Container(
                                    child: MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: Swiper(
                                    itemCount: snapshot.data.documents.length,
                                    viewportFraction: 0.6,
                                    scale: 0.8,
                                    loop: false,
                                    onIndexChanged: (_) =>
                                        Vibrate.feedback(FeedbackType.light),
                                    itemBuilder: (context, index) {
                                      DocumentSnapshot ds =
                                          snapshot.data.documents[index];
                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: index,
                                        //duration: const Duration(milliseconds: 800),
                                        delay:
                                            const Duration(milliseconds: 100),
                                        child: SlideAnimation(
                                          child: FadeInAnimation(
                                              child: Recommended_Item(
                                            image: ds['image'],
                                            name: ds['name'],
                                            description: ds['description'],
                                            index: index,
                                            icon: ds['icon'],
                                          )),
                                        ),
                                      );
                                    },
                                  ),
                                ));
                            }
                          }),
                    ),
                  )
                : Container(),
            listVisible == true
                ? Padding(
                    padding: EdgeInsets.only(bottom: 65),
                    child: SizeUp(
                        delay: 300,
                        child: CTA(
                          text: "create my own",
                          voidCallback: () {
                            Vibrate.feedback(FeedbackType.medium);
                            Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: new CreateHabit(), duration: Duration(milliseconds: 300)));
                          },
                        )),
                  )
                : Container(),
          ],
        ),
      ],
    );
  }
}
