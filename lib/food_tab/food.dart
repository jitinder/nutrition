import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Food extends StatefulWidget {
  const Food({Key? key}) : super(key: key);

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {
  Widget _dataContainer(double height, Widget child) {
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
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
    return ListView(
      children: [
        _dataContainer(
          300,
          Column(
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
        ),
        _dataContainer(
          200,
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Breakfast",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    ActionChip(
                      elevation: 0,
                      label: Align(
                        alignment: Alignment.topCenter,
                        child: Icon(
                          Icons.add,
                          size: 20,
                        ),
                      ),
                      onPressed: () {
                        print("Add to breakfast");
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 4,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: DataTable(
                    headingTextStyle: Theme.of(context).textTheme.titleSmall,
                    horizontalMargin: 0,
                    headingRowHeight: 30,
                    dataRowHeight: 25,
                    dividerThickness: 0,
                    // columnSpacing: 5,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text("Item"),
                      ),
                      DataColumn(
                        label: Text("Kcals"),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Text("C"),
                      ),
                      DataColumn(
                        label: Text("P"),
                      ),
                      DataColumn(
                        label: Text("F"),
                      ),
                    ],
                    rows: [
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Name')),
                          DataCell(Text('100')),
                          DataCell(Text('5')),
                          DataCell(Text('10')),
                          DataCell(Text('15')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        _dataContainer(
          150,
          Text("Lunch"),
        ),
        _dataContainer(
          150,
          Text("Snack"),
        ),
        _dataContainer(
          150,
          Text("Dinner"),
        ),
      ],
    );
  }
}
