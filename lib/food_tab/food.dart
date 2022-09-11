import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Food extends StatefulWidget {
  const Food({Key? key}) : super(key: key);

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {
  Widget _macrosBox(String name, double progress, Color color, int currentValue,
      int maxValue) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$currentValue",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.black),
                textScaleFactor: 0.7,
              ),
              Text(
                " / $maxValue",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.black54),
                textScaleFactor: 0.6,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: LinearProgressIndicator(
              value: progress,
              color: color,
              backgroundColor: color.withOpacity(0.3),
            ),
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(name),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 300,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            Icons.whatshot,
            color: Colors.deepOrange,
          ),
          const Text("Calories"),
          Center(
            child: Text(
              "2200",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.black,
                  ),
              textScaleFactor: 1.5,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: _macrosBox(
                  "Carbohydrate",
                  0.5,
                  Colors.teal,
                  100,
                  200,
                ),
              ),
              Expanded(
                flex: 1,
                child: _macrosBox(
                  "Protein",
                  0.7,
                  Colors.blueAccent,
                  140,
                  200,
                ),
              ),
              Expanded(
                flex: 1,
                child: _macrosBox(
                  "Fat",
                  0.4,
                  Colors.indigoAccent,
                  80,
                  200,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
