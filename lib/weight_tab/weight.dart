import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:nutrition/util/WeightLog.dart';

import '../util/DataContainer.dart';

class Weight extends StatelessWidget {
  const Weight({Key? key}) : super(key: key);

  static List<WeightLog> data = [
    WeightLog(77.0, DateTime(2017, 9, 19)),
    WeightLog(79.0, DateTime(2017, 9, 22)),
    WeightLog(78.0, DateTime(2017, 9, 25)),
    WeightLog(77.5, DateTime(2017, 9, 29)),
  ];

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
                child: Text("Weight (kg) over Time"),
              ),
              Expanded(
                flex: 4,
                child: Center(
                  child: TimeSeriesChart(
                    [
                      Series<WeightLog, DateTime>(
                        id: 'Weight',
                        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
                        domainFn: (WeightLog log, _) => log.logTime,
                        measureFn: (WeightLog log, _) => log.weightInKgs,
                        data: data,
                      )
                    ],
                    animate: false,
                  ),
                ),
              ),
            ],
          ),
        ),
        dataContainer(
          300,
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Log",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    ActionChip(
                      elevation: 0,
                      label: Icon(
                        Icons.add,
                      ),
                      onPressed: () {
                        print("Add to Log");
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
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
                        label: Text("Weight (kg)"),
                      ),
                      DataColumn(
                        label: Text("Date"),
                      ),
                    ],
                    rows: [
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('77')),
                          DataCell(Text('25th Aug 2022')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
