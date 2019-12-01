import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emood/pages/habits_overview.dart';
import 'package:emood/utils/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vibrate/vibrate.dart';


class UploadHabit extends StatefulWidget {

  final int amount;
  final int icon;
  final String name;

  const UploadHabit({Key key, this.amount, this.icon, this.name}) : super(key: key);

  @override
  _UploadHabitState createState() => _UploadHabitState();
}

class _UploadHabitState extends State<UploadHabit> {

  FirebaseUser userdata;

  Future createHabit() async{
     getUser().then((user) async{
      userdata = user;
      await Firestore.instance.collection('user').document(user.uid).collection('habits').add({
        'amount_per_week': widget.amount != null ? widget.amount : 1,
        'daily': widget.amount == 7 ? true : false,
        'icon': widget.icon,
        'name': widget.name,
        'level': 'Wood',
        'reps_done': 0,
        'this_week': 0
      });
       Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: HabitsOverview(user: user), duration: Duration(milliseconds: 300)));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    createHabit().whenComplete((){
      Vibrate.feedback(FeedbackType.success);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(0xFFFAFAFA),
      child: Center(
        child: SpinKitPulse(
          color: Color(0xFFF4A261),
          size: 70,
        ),
      ),
    );
  }
}