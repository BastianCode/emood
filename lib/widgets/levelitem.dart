import 'package:emood/utils/level.dart';
import 'package:flutter/material.dart';

class LevelItem extends StatefulWidget {

  final Level level;

  const LevelItem({Key key, this.level}) : super(key: key);


  @override
  _LevelItemState createState() => _LevelItemState();
}

class _LevelItemState extends State<LevelItem> {
  @override
  Widget build(BuildContext context) {
    return Container( 
      width: 250,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 15),
            blurRadius: 26,
            color: Colors.black.withAlpha(29)
          )
        ]
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
                            "assets/" + widget.level.name + ".png",
                            scale: 1.8,
                          ),
                          ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text(
                          widget.level.name,
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
              top: 22,
              left: 85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.level.name.toUpperCase()+" LEVEL",
                    style: TextStyle(
                        color: Color(0xFF2F2E41),
                        fontSize: 16,
                        height: 0.95,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Opacity(
                      opacity: 0.37,
                      child: Text(
                        widget.level.milestone,
                        style: TextStyle(
                          color: Color(0xFF2F2E41),
                          fontWeight: FontWeight.w500,
                          fontSize: 13
                        ),
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