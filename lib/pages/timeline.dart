import 'package:YASS/widgets/header.dart';
import 'package:YASS/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Assigning the collection named 'users' saved in the linked firestore database to the variable usersRef
final usersRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  void initState() {
    createUser();
    super.initState();
  }

  createUser() {
    usersRef.document("asdfasfd").setData({
      "username": "Jordy",
      "postsCount": 1,
      "isAdmin": false
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: header(context, isAppTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          final List<Text> children = snapshot.data.documents.map((doc) => Text(doc['username'])).toList();
          return Container(
            child: ListView(
              children: children,
            ),
          );
        },
      ),
    );
  }
}
