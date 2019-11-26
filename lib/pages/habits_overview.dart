import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emood/utils/habit_item.dart';
import 'package:emood/utils/navbar.dart';
import 'package:emood/utils/showup.dart';
import 'package:emood/utils/sign_in.dart';
import 'package:emood/utils/sizeup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HabitsOverview extends StatefulWidget {
  final FirebaseUser user;

  const HabitsOverview({Key key, this.user}) : super(key: key);

  @override
  _HabitsOverviewState createState() => _HabitsOverviewState();
}

class _HabitsOverviewState extends State<HabitsOverview> {
  bool listVisible;

  @override
  void initState() {
    super.initState();
    listVisible = false;
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        listVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      bottomNavigationBar: Hero(
        child: Navbar(1, widget.user),
        tag: "nav",
      ),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
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
              padding: EdgeInsets.only(left: 35, right: 35, top: 110),
              child: Row(
                children: <Widget>[
                  SizeUp(
                      delay: 1400,
                      child: Image.asset("assets/plus.png", scale: 2)),
                  Padding(
                    padding: EdgeInsets.only(left: 70),
                    child: ShowUp(
                      delay: 400,
                      child: Text(
                        "Your Habits",
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0B0B0B)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            listVisible == true
                ? Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection('user')
                              .document(widget.user.uid)
                              .collection('habits')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text("ERROR while loading!");
                            }
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return CircularProgressIndicator();
                                break;
                              default:
                                return Container(
                                    child: MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView.builder(
                                      itemCount: snapshot.data.documents.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot ds =
                                            snapshot.data.documents[index];
                                        return AnimationConfiguration
                                            .staggeredList(
                                          position: index,
                                          duration: const Duration(
                                              milliseconds: 800),
                                          delay:
                                              const Duration(milliseconds: 100),
                                          child: SlideAnimation(
                                            verticalOffset: 150.0,
                                            child: FadeInAnimation(
                                              child: new HabitItem(
                                                daily: ds['daily'],
                                                amount_per_week:
                                                    ds['amount_per_week'],
                                                this_week_done: ds['this_week'],
                                                name: ds['name'],
                                                level: ds['level'],
                                                reps_done: ds['reps_done'],
                                                icon: ds['icon'],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ));
                            }
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
