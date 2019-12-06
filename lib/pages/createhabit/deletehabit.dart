import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emood/pages/habits_overview.dart';
import 'package:emood/utils/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vibrate/vibrate.dart';


class DeleteHabit extends StatefulWidget {

  final String id;

  const DeleteHabit({Key key, this.id}) : super(key: key);

  @override
  _DeleteHabitState createState() => _DeleteHabitState();
}

class _DeleteHabitState extends State<DeleteHabit> {

  FirebaseUser userdata;

  Future deleteHabit() async{
     getUser().then((user) async{
      userdata = user;
      await Firestore.instance.collection('user').document(user.uid).collection('habits').document(widget.id).delete();
       Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: HabitsOverview(user: user), duration: Duration(milliseconds: 300)));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    deleteHabit().whenComplete((){
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