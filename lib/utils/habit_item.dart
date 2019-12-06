import 'package:emood/pages/habitdetail.dart';
import 'package:emood/utils/sign_in.dart';
import 'package:emood/widgets/animated_counter.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vibrate/vibrate.dart';

class HabitItem extends StatefulWidget {
  const HabitItem(
      {Key key,
      this.daily,
      this.amount_per_week,
      this.level,
      this.name,
      this.reps_done,
      this.this_week_done,
      this.icon, this.id})
      : super(key: key);

  @override
  _HabitItemState createState() => _HabitItemState();

  final bool daily;
  final int amount_per_week;
  final String level;
  final String name;
  final int reps_done;
  final int this_week_done;
  final int icon;
  final String id;
}

class _HabitItemState extends State<HabitItem> {

  double perc = 0;
  Color col;
  double perc_showed;

  @override
  void initState() {
    super.initState();
    perc_showed = 0;
    perc = widget.this_week_done / widget.amount_per_week;

    if (perc < 0.30){
      col = Color(0xFFE67F7A);
    }else if(perc >= 0.30 && perc <=0.70){
      col = Color(0xFFF4A261);
    }else{
      col = Color(0xFF4CD1B7);
    }

    Future.delayed(const Duration(milliseconds: 620), () {
      setState(() {
        perc_showed = perc;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Vibrate.feedback(FeedbackType.medium);
        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: HabitDetail(daily: widget.daily,name: widget.name, streak: widget.reps_done, level: widget.level, amount: widget.amount_per_week, id: widget.id,), duration: Duration(milliseconds: 300)));
      },
        child: Container(
        margin: EdgeInsets.only(top: 0, bottom: 15, left: 20, right: 20),
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          shape: BoxShape.rectangle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 15),
                blurRadius: 26,
                color: Colors.black.withAlpha(29))
          ],
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 19,
              left: 18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Image.asset(
                        "assets/" + widget.level + ".png",
                        scale: 1.8,
                      ),
                      Positioned(top: 0, left: 0, right:0, bottom:0, child: Center(child: Image.asset("assets/"+widget.icon.toString()+".png", scale: 1.7,)))     ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(
                      widget.level,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 23,
              left: 88,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.name.toUpperCase(),
                    style: TextStyle(
                        color: Color(0xFF2F2E41),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Opacity(
                      opacity: 0.37,
                      child: Text(
                        widget.daily == true
                            ? "daily"
                            : widget.amount_per_week.toString() + " times a week",
                        style: TextStyle(
                          color: Color(0xFF2F2E41),
                          fontWeight: FontWeight.w500,
                          fontSize: 17
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: 18,
              bottom: 15,
              child: CircularPercentIndicator(
                radius: 57,
                backgroundColor: Color(0xFFF0F0F0),
                lineWidth: 8.0,
                animationDuration: 500,
                animation: true,
                animateFromLastPercent: true,
                percent: perc_showed,
                progressColor: col, 
                center: Opacity(opacity: 0.8,child: AnimatedCount(count: (perc_showed*100).round(),col: col, duration: Duration(milliseconds: 500),)),
                circularStrokeCap: CircularStrokeCap.round,
              ),
            )
          ],
        ),
      ),
    );
  }
}
