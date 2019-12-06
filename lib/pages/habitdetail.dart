import 'package:emood/pages/createhabit/deletehabit.dart';
import 'package:emood/utils/level.dart';
import 'package:emood/utils/showup.dart';
import 'package:emood/utils/sizeup.dart';
import 'package:emood/widgets/levelitem.dart';
import 'package:emood/widgets/levelitem2.dart';
import 'package:emood/widgets/milestone.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vibrate/vibrate.dart';

class HabitDetail extends StatefulWidget {
  final int amount;
  final int streak;
  final String name;
  final String level;
  final bool daily;
  final String id;

  const HabitDetail(
      {Key key,
      this.amount,
      this.streak,
      this.name,
      this.level,
      this.id,
      this.daily})
      : super(key: key);

  @override
  _HabitDetailState createState() => _HabitDetailState();
}

class _HabitDetailState extends State<HabitDetail> {
  ScrollController scrollController = ScrollController();
  List<Level> list;

  int getLevelID() {
    switch (widget.level) {
      case "Wood":
        return 0;
      case "Stone":
        return 1;
      case "Coal":
        return 2;
      case "Gold":
        return 3;
      case "Ruby":
        return 4;
      case "Diamond":
        return 5;
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      list = getList(widget.daily);
    });

  }

  List<Level> getList(bool daily) {
    if (daily == true) {
      return [
        Level(name: "Wood", milestone: "after starting"),
        Level(name: "Stone", milestone: "after 5 days"),
        Level(name: "Coal", milestone: "after 15 days"),
        Level(name: "Gold", milestone: "after 30 days"),
        Level(name: "Ruby", milestone: "after 60 days"),
        Level(name: "Diamond", milestone: "after 100 days")
      ].toList();
    } else {
      return [
        Level(name: "Wood", milestone: "after starting"),
        Level(name: "Stone", milestone: "after 3 weeks"),
        Level(name: "Coal", milestone: "after 6 weeks"),
        Level(name: "Gold", milestone: "after 12 weeks"),
        Level(name: "Ruby", milestone: "after 25 weeks"),
        Level(name: "Diamond", milestone: "after 50 weeks")
      ].toList();
    }
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
              padding: EdgeInsets.only(left: 19, right: 10, top: 110),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Vibrate.feedback(FeedbackType.light);
                      Navigator.pop(context);
                    },
                    child: SizeUp(
                        delay: 1400,
                        child: Container(
                            width: 50,
                            height: 50,
                            child: Image.asset("assets/back.png", scale: 2))),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 50, right: 20),
                      child: ShowUp(
                        delay: 400,
                        child: Container(
                          child: Text(
                            widget.name.toUpperCase(),
                            style: TextStyle(
                                fontSize: 35,
                                height: 0.9,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0B0B0B)),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 60, left: 19),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Vibrate.feedback(FeedbackType.medium);
                      showDialog<bool>(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: new Text("Delete Habit"),
                              content: new Text(
                                  "Are you sure you want to delete this habit?"),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  child: Text("Yes"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.fade,
                                            child: DeleteHabit(
                                              id: widget.id,
                                            ),
                                            duration:
                                                Duration(milliseconds: 300)));
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: Text("No"),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            );
                          });
                    },
                    child: SizeUp(
                        delay: 1600,
                        child: Container(
                            width: 50,
                            height: 50,
                            child:
                                Image.asset("assets/delete.png", scale: 1.87))),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 20),
                      child: ShowUp(
                        delay: 800,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ShowUp(
                              delay: 600,
                              child: Container(
                                width: 120,
                                height: 60,
                                child: Center(
                                  child: Stack(
                                    children: <Widget>[
                                      Center(
                                          child:
                                              Image.asset("assets/flame.png")),
                                      Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                widget.daily == true
                                                    ? widget.streak.toString() +
                                                        " DAYS"
                                                    : widget.streak.toString() +
                                                        " WEEKS",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    height: 0.9,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF2F2E41)),
                                              ),
                                            ),
                                            Opacity(
                                              opacity: 0.37,
                                              child: Text(
                                                "STREAK",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF2F2E41)),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            ShowUp(
                              delay: 600,
                              child: Container(
                                width: 140,
                                height: 60,
                                child: Center(
                                  child: Stack(
                                    children: <Widget>[
                                      Center(
                                        child: Image.asset("assets/repeat.png"),
                                      ),
                                      Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                widget.daily == true
                                                    ? "EVERY DAY"
                                                    : widget.amount.toString() +
                                                        " TIMES A WEEK",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    height: 0.9,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF2F2E41)),
                                              ),
                                            ),
                                            Opacity(
                                              opacity: 0.37,
                                              child: Text(
                                                "AMOUNT",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF2F2E41)),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ShowUp(
                delay: 1000,
                child: SingleChildScrollView(
                    child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 95,
                        child: SizedBox(
                          child: ListView.builder(
                          shrinkWrap: true,
                          controller: scrollController,
                          itemCount: getLevelID() + 2,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Milestone(
                                containerOnly: false,
                                firstObject: true,
                              );
                            }
                            if (index != getLevelID() + 1) {
                              return Milestone(
                                containerOnly: false,
                                firstObject: false,
                              );
                            } else {
                              if(index != 6){
                              return Milestone(
                                containerOnly: true,
                                firstObject: true,
                              );
                              }
                            }
                          },
                            ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                            child: ListView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                            itemCount: getLevelID() + 2,
                            itemBuilder: (context, index) {
                              if(index == 0){
                                return Padding(
                                  padding: const EdgeInsets.only(top: 40.0, left: 15, right: 15),
                                  child: LevelItem(level: list[index],),
                                );
                              }if(index < getLevelID()+1){
                                return Padding(
                                  padding: const EdgeInsets.only(top: 33.0, left: 15, right: 15),
                                  child: LevelItem(level: list[index],),
                                );
                              }else{
                                if(index != 6){
                                return Padding(
                                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                                  child: LevelItem2(level: list[index],),
                                );
                                }
                              }            
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
