import 'package:flutter/material.dart';

Widget dataContainer(double height, Widget child) {
  return Container(
    width: double.maxFinite,
    height: height,
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(16),
    decoration: ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    child: child,
  );
}
