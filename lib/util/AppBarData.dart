// Custom wrapper for app bar values for each tab

import 'package:flutter/material.dart';

class AppBarData {
  Widget? title;
  Widget? leading;
  List<Widget>? actions;

  AppBarData({this.title, this.leading, this.actions});
}

final emptyAppBarData = AppBarData(
  title: Container(),
  leading: Container(),
  actions: [
    Container(),
  ],
);

final weightAppBarData = AppBarData(
  title: Container(
    padding: const EdgeInsets.symmetric(
      vertical: 6,
      horizontal: 16,
    ),
    decoration: const ShapeDecoration(
      color: Colors.white,
      shape: StadiumBorder(),
    ),
    child: const Text("Weight"),
  ),
);

final foodAppBarData = AppBarData(
  title: Container(
    padding: EdgeInsets.symmetric(
      vertical: 6,
      horizontal: 16,
    ),
    decoration: ShapeDecoration(
      color: Colors.white,
      shape: StadiumBorder(),
    ),
    child: Text("Today"),
  ),
  leading: IconButton(
    icon: Icon(Icons.trending_up),
    onPressed: () {
      print("Clicked Calendar");
    },
    splashRadius: 16,
  ),
  actions: [
    IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        print("Clicked Settings");
      },
      splashRadius: 16,
    ),
  ],
);
