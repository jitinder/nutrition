import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        titleTextStyle: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.calendar_month),
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              "",
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
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
