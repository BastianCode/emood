import 'package:emood/utils/level.dart';
import 'package:flutter/material.dart';

class LevelItem2 extends StatefulWidget {


  final Level level;

  const LevelItem2({Key key, this.level}) : super(key: key);

  @override
  _LevelItem2State createState() => _LevelItem2State();
}

class _LevelItem2State extends State<LevelItem2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 14,
            left: 18,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.asset(
                      "assets/greylevel.png",
                      scale: 1.8,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Container(
                    width: 40,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Color(0xFFE9E9E9),
                      borderRadius: BorderRadius.circular(19)  
                    ),
                  )
                ),
              ],
            ),
          ),
          Positioned(
            top: 22,
            left: 85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Container(
                    width: 120,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Color(0xFFE9E9E9),
                      borderRadius: BorderRadius.circular(19)  
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Opacity(
                    opacity: 0.37,
                    child: Text(
                      widget.level.milestone,
                      style: TextStyle(
                          color: Color(0xFF2F2E41),
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
