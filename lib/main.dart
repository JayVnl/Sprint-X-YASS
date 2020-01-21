import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:YASS/pages/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firestore.instance.settings(timestampsInSnapshotsEnabled: true).then(
  (_) {
    print("Timestamps enabled in snapshots\n");
  }, onError: (_) {
    print("Error enabling timestamps in snapshots");
  });
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
