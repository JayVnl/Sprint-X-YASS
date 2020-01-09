import 'package:YASS/widgets/header.dart';
import 'package:flutter/material.dart';

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: header(context, isAppTitle: true),
      body: Text('Timeline'),
    );
  }
}
