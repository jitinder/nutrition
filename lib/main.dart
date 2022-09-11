import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutrition/util/AppBarData.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: CupertinoColors.lightBackgroundGray),
      home: const MyHomePage(title: 'Page Title'),
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
  int _tabIndex = 1;
  List tabs = [
    Container(),
    Food(),
    Container(),
  ];
  List<AppBarData> appBarData = [
    emptyAppBarData,
    foodAppBarData,
    emptyAppBarData,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: StadiumBorder(),
          ),
          child: SalomonBottomBar(
            currentIndex: _tabIndex,
            onTap: (int index) {
              setState(() {
                _tabIndex = index;
              });
            },
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
