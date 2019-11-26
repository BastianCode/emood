import 'package:flutter/material.dart';
class AnimatedCount extends ImplicitlyAnimatedWidget {
  final int count;
  final Color col;

  AnimatedCount({
    Key key,
    @required this.count,
    @required Duration duration,
    this.col,
    Curve curve = Curves.linear
  }) : super(duration: duration, curve: curve, key: key);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() => _AnimatedCountState();
}

class _AnimatedCountState extends AnimatedWidgetBaseState<AnimatedCount> {
  IntTween _count;

  @override
  Widget build(BuildContext context) {
    return new Text(_count.evaluate(animation).toString(), style: TextStyle(
      color: widget.col,
      fontSize: 17,
      fontWeight: FontWeight.bold
    ),);
  }

  @override
  void forEachTween(TweenVisitor visitor) {
    _count = visitor(_count, widget.count, (dynamic value) => new IntTween(begin: value));
  }
}
