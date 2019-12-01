import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emood/pages/createhabit/uploadhabit.dart';
import 'package:emood/pages/habits_overview.dart';
import 'package:emood/pages/rec_amount.dart';
import 'package:emood/pages/recommeded_habits.dart';
import 'package:emood/utils/habit_item.dart';
import 'package:emood/utils/showup.dart';
import 'package:emood/utils/sign_in.dart';
import 'package:emood/utils/sizeup.dart';
import 'package:emood/widgets/cta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:vibrate/vibrate.dart';

class CreateHabit extends StatefulWidget {
  @override
  _CreateHabitState createState() => _CreateHabitState();
}

class _CreateHabitState extends State<CreateHabit> {
  PageController pageController = PageController();
  TextEditingController textEditingController = TextEditingController();
  FirebaseUser userdata;


  initState() {
    super.initState();

    if (habitname != null) {
      textEditingController.text = habitname;
    }
  }

  String habitname;
  int amountperweek;
  int icon;


  Future createNewHabit() async{
     Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: UploadHabit(icon: icon, name: habitname, amount: amountperweek,), duration: Duration(milliseconds: 300)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: body(context),
      resizeToAvoidBottomInset: false,
    );
  }

  body(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            name(context),
            amount(context),
            selecticon(context),
            overview(context)
          ],
        ),
        Positioned(
          left: 19,
          top: 109,
          child: GestureDetector(
              onTap: () {
                if (pageController.page == 0) {
                  Vibrate.feedback(FeedbackType.light);
                  Navigator.pop(context);
                } else {
                  pageController.previousPage(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.decelerate);
                }
              },
              child: SizeUp(
                  delay: 1000,
                  child: Container(
                      width: 50,
                      height: 50,
                      child: Image.asset("assets/back.png", scale: 2)))),
        ),
        Padding(
          padding: EdgeInsets.only(top: 150),
          child: Align(
            alignment: Alignment.topCenter,
            child: SizeUp(
              delay: 200,
              child: Image.asset("assets/man-middle.png", scale: 1.7),
            ),
          ),
        ),
      ],
    );
  }

  overview(BuildContext context){
    return Stack(
      children: <Widget>[
         Positioned(
          top: 290,
          left: 75,
          right: 75,
          child: ShowUp(
            delay: 600,
            child: Text(
              "Perfect! Are you happy with it?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF0B0B0B),
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Positioned(
          bottom: 350,
          left: 0,
          right: 0,
          child: ShowUp(
            delay: 800,
                child: IgnorePointer(
                child: HabitItem(
                daily: this.amountperweek == 7 ? true:false,
                name: this.habitname,
                amount_per_week: this.amountperweek,
                level: "Wood",
                icon: this.icon,
                this_week_done: 0,
                reps_done: 0,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 65),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizeUp(
              delay: 1000,
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

  selecticon(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 290,
          left: 75,
          right: 75,
          child: ShowUp(
            delay: 600,
            child: Text(
              "Now choose an icon that fits your habit",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF0B0B0B),
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Positioned(
          bottom: 200,
          left: 45,
          right: 45,
          child: ShowUp(
            delay: 800,
              child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    clickableIcon(() => selectIcon(1), 1),
                    clickableIcon(() => selectIcon(2), 2),
                    clickableIcon(() => selectIcon(3), 3),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      clickableIcon(() => selectIcon(4), 4),
                      clickableIcon(() => selectIcon(5), 5),
                      clickableIcon(() => selectIcon(6), 6),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      clickableIcon(() => selectIcon(7), 7),
                      clickableIcon(() => selectIcon(8), 8),
                      clickableIcon(() => selectIcon(9), 9),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  amount(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 290,
          left: 75,
          right: 75,
          child: ShowUp(
            delay: 600,
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
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 250.0),
            child: ShowUp(
              delay: 800,
              child: SleekCircularSlider(
                min: 1.0,
                max: 7.0,
                initialValue: 1,
                onChange: (double value) {
                  amountperweek = value.round();
                },
                onChangeEnd: (value) {
                  amountperweek = value.round();
                  Vibrate.feedback(FeedbackType.medium);
                  pageController.nextPage(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.decelerate);
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
                    infoProperties: InfoProperties(
                        mainLabelStyle:
                            TextStyle(color: Color(0xFFE67F7A), fontSize: 40),
                        modifier: (value) {
                          return value.round().toString();
                        }),
                    animationEnabled: false,
                    size: 200,
                    angleRange: 240),
              ),
            ),
          ),
        ),
      ],
    );
  }

  name(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 290,
          left: 75,
          right: 75,
          child: ShowUp(
            delay: 600,
            child: Text(
              "Whats the name of the habit?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF0B0B0B),
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Positioned(
          top: 400,
          left: 40,
          right: 40,
          child: Align(
              alignment: Alignment.topCenter,
              child: SizeUp(
                delay: 800,
                child: Container(
                  height: 65,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(21),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 15),
                          blurRadius: 26,
                          color: Colors.black.withOpacity(0.16),
                        )
                      ]),
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: TextField(
                      controller: textEditingController,
                      onChanged: (text) {
                        habitname = text;
                      },
                      autocorrect: false,
                      style: TextStyle(
                        color: Color(0xFF0B0B0B),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLength: 20,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Habit name',
                        counterText: "",
                        hintStyle: TextStyle(
                            color: Color(0xFFE3E3E3),
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 65),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizeUp(
              delay: 1000,
              child: CTA(
                  text: "continue",
                  voidCallback: () {
                    if (habitname != null &&
                        habitname.replaceAll(" ", "") != "") {
                      Vibrate.feedback(FeedbackType.medium);
                      pageController.nextPage(
                          duration: Duration(milliseconds: 800),
                          curve: Curves.decelerate);
                    }
                  }),
            ),
          ),
        ),
      ],
    );
  }

  selectIcon(int icon) {
    this.icon = icon;
    Vibrate.feedback(FeedbackType.medium);
    pageController.nextPage(
        duration: Duration(milliseconds: 800), curve: Curves.decelerate);

    setState(() {
      
    });
  }

  clickableIcon(VoidCallback callback, int icon) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 80,
        width: 80,
        child: Image.asset("assets/" + icon.toString() + ".png",
            scale: 1.2, color: Color(0xFF707070)),
      ),
    );
  }
}
