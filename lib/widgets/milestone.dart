import 'package:flutter/material.dart';


class Milestone extends StatefulWidget {

  final bool containerOnly;
  final bool firstObject;

  const Milestone({Key key, this.containerOnly, this.firstObject}) : super(key: key);
  @override
  _MilestoneState createState() => _MilestoneState();
}

class _MilestoneState extends State<Milestone> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      height: widget.firstObject == true ? widget.containerOnly ? 55 : 100 : 135,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: widget.firstObject == true ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Opacity(
            opacity: 0.15,
            child: Container(
              height: widget.firstObject == true ? 55 : 100,
              width: 5,
              decoration: BoxDecoration(
                color: Color(0xFF707070),
                borderRadius: BorderRadius.circular(29)
              ),
            ),
          ),
          widget.containerOnly == false ?
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF4A261)
              ),
              
            ),
          ) : Container()
        ],
      ),
    );
  }
}