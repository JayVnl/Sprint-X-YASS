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
    getUsers();
    super.initState();
  }

// Collect the current documents of the collection 'users' and then print out each document with their own fields
  getUsers() async {
    final QuerySnapshot snapshot = await usersRef.getDocuments();
    snapshot.documents.forEach((DocumentSnapshot doc) {
      print(doc.data);
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: header(context, isAppTitle: true),
      body: circularProgress(),
    );
  }
}
