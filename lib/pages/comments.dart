import 'package:YASS/widgets/header.dart';
import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  final String postId;
  final String postOwnerId;
  final String postMediaUrl;

  Comments({
    this.postId,
    this.postOwnerId,
    this.postMediaUrl,
  });

  @override
  CommentsState createState() => CommentsState(
        postId: this.postId,
        postOwnerId: this.postOwnerId,
        postMediaUrl: this.postMediaUrl,
      );
}

class CommentsState extends State<Comments> {
  TextEditingController commentController = TextEditingController();
  final String postId;
  final String postOwnerId;
  final String postMediaUrl;

  CommentsState({
    this.postId,
    this.postOwnerId,
    this.postMediaUrl,
  });

  buildComments() {
    return Text("Comment");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: header(context, titleText: "Comments"),
      body: Column(
        children: <Widget>[
          Expanded(child: buildComments()),
          Divider(color: Colors.white,),
          ListTile(
            title: TextFormField(
              style: TextStyle(color: Colors.white),
              controller: commentController,
              decoration: InputDecoration(
                labelText: "Write a comment...",
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            trailing: OutlineButton(
              onPressed: () => print("add comment"),
              borderSide: BorderSide.none,
              child: Text("Post"),
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class Comment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Comment');
  }
}
