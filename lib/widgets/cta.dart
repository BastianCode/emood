import 'package:flutter/material.dart';

class CTA extends StatefulWidget {
  final VoidCallback voidCallback;
  final String text;

  const CTA({Key key, this.voidCallback, this.text}) : super(key: key);

  @override
  _CTAState createState() => _CTAState();
}

class _CTAState extends State<CTA> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      width: 321,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF4A261), Color(0xFFE67F7A)]),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 15),
            blurRadius: 26,
            color: Colors.black.withOpacity(0.16),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.voidCallback,
          child: Center(
            child: Text(
              widget.text.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
