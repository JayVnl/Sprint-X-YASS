import 'package:flutter/material.dart';

AppBar header(context, { bool isAppTitle = false, String titleText }) {
  return AppBar(
    title: Text(
      isAppTitle ? "YASS" : titleText,
      style: TextStyle(
        color: Colors.white,
        fontFamily: isAppTitle ? "VenusRising" : "Manjari",
        fontSize: isAppTitle ? 40.0 : 22.0,
      ),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).accentColor,
  );
}
