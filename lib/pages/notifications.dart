import 'package:YASS/pages/home.dart';
import 'package:YASS/pages/post_screen.dart';
import 'package:YASS/pages/profile.dart';
import 'package:YASS/widgets/header.dart';
import 'package:YASS/widgets/progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  getNotifications() async {
    QuerySnapshot snapshot = await notificationsRef
        .document(currentUser.id)
        .collection('feedItems')
        .orderBy('timestamp', descending: true)
        .limit(50)
        .getDocuments();
    List<NotificationsItem> feedItems = [];
    snapshot.documents.forEach((doc) {
      feedItems.add(NotificationsItem.fromDocument(doc));
    });
    // snapshot.documents.forEach((doc) {
    //   print('Activity Feed Item: ${doc.data}');
    // });
    return feedItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: header(context, titleText: "Notifications"),
      body: Container(
        child: FutureBuilder(
            future: getNotifications(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return circularProgress();
              }
              return ListView(
                children: snapshot.data,
              );
            }),
      ),
    );
  }
}

Widget mediaPreview;
String activityItemText;

class NotificationsItem extends StatelessWidget {
  final String username;
  final String userId;
  final String postUserId;
  final String type;
  final String mediaUrl;
  final String postId;
  final String userProfileImage;
  final String commentData;
  final Timestamp timestamp;

  const NotificationsItem({
    this.username,
    this.userId,
    this.postUserId,
    this.type,
    this.mediaUrl,
    this.postId,
    this.userProfileImage,
    this.commentData,
    this.timestamp,
  });

  factory NotificationsItem.fromDocument(DocumentSnapshot doc) {
    return NotificationsItem(
      username: doc['username'],
      userId: doc['userId'],
      postUserId: currentUser.id,
      type: doc['type'],
      postId: doc['postId'],
      userProfileImage: doc['userProfileImage'],
      commentData: doc['commentData'],
      timestamp: doc['timestamp'],
      mediaUrl: doc['mediaUrl'],
    );
  }

  showPost(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostScreen(
          userId: postUserId,
          postId: postId,
        ),
      ),
    );
  }

  configureMediaPreview(context) {
    if (type == "like" || type == "comment") {
      mediaPreview = GestureDetector(
        onTap: () => showPost(context),
        child: Container(
          height: 50.0,
          width: 50.0,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(mediaUrl),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      mediaPreview = Text('');
    }

    if (type == 'like') {
      activityItemText = "liked your post";
    } else if (type == 'follow') {
      activityItemText = "is following you";
    } else if (type == 'comment') {
      activityItemText = 'replied: $commentData';
    } else {
      activityItemText = "Error: Unknown type '$type'";
    }
  }

  @override
  Widget build(BuildContext context) {
    configureMediaPreview(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 2.0),
      child: Container(
        color: Colors.black26,
        child: ListTile(
          title: GestureDetector(
            onTap: () => showProfile(context, profileId: userId),
            child: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' $activityItemText',
                    ),
                  ]),
            ),
          ),
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(userProfileImage),
          ),
          subtitle: Text(
            timeago.format(timestamp.toDate()),
            style: TextStyle(color: Colors.white60),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: mediaPreview,
        ),
      ),
    );
  }
}

showProfile(BuildContext context, {String profileId}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Profile(
        profileId: profileId,
      ),
    ),
  );
}
