// Custom wrapper for app bar values for each tab

import 'package:flutter/material.dart';

class AppBarData {
  Widget? title;
  Widget? leading;
  List<Widget>? actions;

  AppBarData({this.title, this.leading, this.actions});
}

Widget titlePill(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(
      vertical: 6,
      horizontal: 16,
    ),
    decoration: const ShapeDecoration(
      color: Colors.white,
      shape: StadiumBorder(),
    ),
    child: Text(text),
  );
}

final emptyAppBarData = AppBarData(
  title: Container(),
  leading: Container(),
  actions: [
    Container(),
  ],
);

final weightAppBarData = AppBarData(
  title: titlePill("Weight"),
);

final progressAppBarData = AppBarData(title: titlePill("Progress"), actions: [
  IconButton(
    icon: Icon(Icons.add_a_photo),
    onPressed: () {
      print("Clicked Add");
    },
    splashRadius: 16,
  ),
]);

final foodAppBarData = AppBarData(
  title: titlePill("Today"),
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
