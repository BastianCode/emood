import 'package:emood/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  runApp(MaterialApp(
  home: Splash(),
  
  theme: ThemeData(fontFamily: 'AV', primaryColor: Color(0xFF0091FF), unselectedWidgetColor: Color(0xFFDCDCDC), backgroundColor: Color(0xFFFFF8F8F8)),
  debugShowCheckedModeBanner: false
  ));

   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.light,
    ));
}