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
          400,
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
      ],
    );
  }
}
