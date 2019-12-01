import 'package:emood/pages/rec_overview.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Recommended_Item extends StatefulWidget {
  final String image;
  final String name;
  final String description;
  final int index;
  final int icon;

  const Recommended_Item(
      {Key key, this.image, this.name, this.description, this.index, this.icon})
      : super(key: key);

  @override
  _Recommended_ItemState createState() => _Recommended_ItemState();
}

class _Recommended_ItemState extends State<Recommended_Item> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: new RecOverview(
                image: widget.image,
                description: widget.description,
                name: widget.name,
                index: widget.index,
                icon: widget.icon,
              ),
              duration: Duration(milliseconds: 600))),
      child: Container(
        margin: EdgeInsets.only(top: 0, bottom: 40, left: 0, right: 0),
        height: 450,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          shape: BoxShape.rectangle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 15),
                blurRadius: 26,
                color: Colors.black.withAlpha(29))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 13),
              child: Hero(
                  flightShuttleBuilder: (
                    BuildContext flightContext,
                    Animation<double> animation,
                    HeroFlightDirection flightDirection,
                    BuildContext fromHeroContext,
                    BuildContext toHeroContext,
                  ) {
                    final Hero toHero = toHeroContext.widget;
                    return Image.asset(
                      "assets/" + widget.image + "rou.png"
                    );
                  },
                  tag: "lanImage" + widget.index.toString(),
                  child: Image.asset("assets/" + widget.image + ".png",
                      scale: 1.87)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Hero(
                tag: "title" + widget.index.toString(),
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    widget.name.toUpperCase(),
                    style: TextStyle(
                        fontSize: 17,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0B0B0B)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25, left: 25, right: 25),
              child: Hero(
                tag: "des" + widget.index.toString(),
                child: Text(
                  widget.description,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 13,
                      color: Color(0xFF0B0B0B)),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
