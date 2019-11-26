import 'dart:async';
import 'package:flutter/material.dart';

class SizeUp extends StatefulWidget {
  final Widget child;
  final int delay;

  SizeUp({@required this.child, this.delay});

  @override
  _SizeUpState createState() => _SizeUpState();
}

class _SizeUpState extends State<SizeUp> with TickerProviderStateMixin {
  AnimationController _animController;
  Animation<double> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset =
        Tween<double>(begin: 0.0, end: 1.0)
            .animate(curve);
    


    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: ScaleTransition(
        scale: _animOffset,
        child: widget.child,
      ),
      opacity: _animController,
    );
  }
}