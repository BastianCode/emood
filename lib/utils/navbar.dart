import 'package:emood/pages/habits_overview.dart';
import 'package:emood/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Navbar extends StatelessWidget {
  final int _index;
  final FirebaseUser user;

  Navbar(this._index, this.user);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: 105,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
            blurRadius: 20,
            color: Color(0xFF000000).withAlpha(40),
          )],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                //* HOME
                width: 50,
                height: 50,
                child: GestureDetector(
                    onTap: () => _index == 0 ? null : Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Home(user: user), duration: Duration(milliseconds: 300))),
                    child: Opacity(
                  opacity: _index == 0 ? 1 : 0.2,
                  child: Image.asset(
                    'assets/nav_home.png',
                    scale: 1.8,
                  ),
                )),
              ),
              Container(
                //* HABIT
                width: 50,
                height: 50,
                child: GestureDetector(
                    onTap: () => _index == 1 ? null : Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: new HabitsOverview(user: user), duration: Duration(milliseconds: 300))),
                    child: Opacity(
                      opacity: _index == 1 ? 1 : 0.2,
                                          child: Image.asset(
                  'assets/nav_habit.png',
                  scale: 1.8,
                ),
                    )),
              ),
              Container(
                //* Stats
                width: 50,
                height: 50,
                child: GestureDetector(
                    //onTap: () => _index == 0 ? null : Navigator.push(context, PageTransition(type: PageTransitionType.downToUp, child: new MyAssignments(), duration: Duration(milliseconds: 300))),
                    child: Opacity(
                      opacity: _index == 2 ? 1 : 0.2,
                                          child: Image.asset(
                  'assets/nav_stats.png',
                  scale: 1.8,
                ),
                    )),
              ),
              Container(
                //* Profile
                width: 50,
                height: 50,
                child: GestureDetector(
                    //onTap: () => _index == 0 ? null : Navigator.push(context, PageTransition(type: PageTransitionType.downToUp, child: new MyAssignments(), duration: Duration(milliseconds: 300))),
                    child: Opacity(
                      opacity: _index == 3 ? 1 : 0.2,
                                          child: Image.asset(
                  'assets/nav_profile.png',
                  scale: 1.8,
                ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
