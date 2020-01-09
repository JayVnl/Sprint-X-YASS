import 'package:flutter/material.dart';
import 'package:YASS/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YASS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff21222B),
        accentColor: Color(0xffD10021),
      ),
      home: Home(),
    );
  }
}
