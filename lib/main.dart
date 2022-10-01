import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutrition/progress_tab/progress.dart';
import 'package:nutrition/util/AppBarData.dart';
import 'package:nutrition/weight_tab/weight.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'food_tab/food.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SNIP',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: CupertinoColors.lightBackgroundGray),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _tabIndex = 0;
  List tabs = [
    Weight(),
    Food(),
    Progress(),
  ];
  List<AppBarData> appBarData = [
    weightAppBarData,
    foodAppBarData,
    progressAppBarData,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        titleTextStyle: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
        foregroundColor: Colors.black,
        elevation: 0,
        title: appBarData[_tabIndex].title,
        leading: appBarData[_tabIndex].leading,
        actions: appBarData[_tabIndex].actions,
      ),
      body: tabs[_tabIndex],
      bottomNavigationBar: SafeArea(
        bottom: false,
        child: Container(
          // margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(),
          ),
          child: SalomonBottomBar(
            currentIndex: _tabIndex,
            onTap: (int index) {
              setState(() {
                _tabIndex = index;
              });
            },
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey.shade400,
            items: [
              SalomonBottomBarItem(
                icon: Icon(Icons.scale),
                title: Text("Weight"),
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.fastfood),
                title: Text("Food"),
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.photo),
                title: Text("Progress"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
