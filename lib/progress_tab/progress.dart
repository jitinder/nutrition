import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../util/DataContainer.dart';

class Progress extends StatefulWidget {
  const Progress({Key? key}) : super(key: key);

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  int _numRows = 2;

  Widget _tempImageRow() => Container(
        margin: EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                "Date",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List<Widget>.filled(
                3,
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        dataContainer(
          300,
          Column(
            children: [
              const Expanded(
                flex: 1,
                child: Icon(
                  Icons.insert_chart_outlined,
                  color: Colors.deepOrange,
                ),
              ),
              const Expanded(
                flex: 1,
                child: Text("Image Analysis"),
              ),
              Expanded(
                flex: 4,
                child: Center(
                  child: LineChart([
                    Series<int, int>(
                      id: "id",
                      data: [],
                      domainFn: (a, b) => a,
                      measureFn: (a, b) => a,
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
        dataContainer(
          75 + (150 * _numRows.toDouble()),
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Photos",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ...List<Widget>.filled(_numRows, _tempImageRow()),
            ],
          ),
        ),
      ],
    );
  }
}
