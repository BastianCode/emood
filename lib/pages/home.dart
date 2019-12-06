import 'package:emood/utils/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {

  final FirebaseUser user;

  const Home({Key key, this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      bottomNavigationBar: Hero(
        child: Navbar(0, widget.user),
        tag: "nav",
      ),
    ); 
  }

  body(BuildContext context){
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
      ],
    );
  }
}