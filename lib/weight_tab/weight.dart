import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutrition/util/WeightLog.dart';

import '../util/DataContainer.dart';

class Weight extends StatefulWidget {
  const Weight({Key? key}) : super(key: key);
  static DateFormat dateFormat = DateFormat('dd MMM yyyy');

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  List<WeightLog> data = [];

  addNewWeight(BuildContext context) {
    TextEditingController controller = new TextEditingController();
    showCupertinoDialog<double>(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        title: Text("Log Weight"),
        content: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: CupertinoTextField(
            controller: controller,
            placeholder: "Weight (kg)",
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            maxLength: 5,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text("Cancel"),
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: Text("Save"),
            isDefaultAction: true,
            onPressed: () {
              double? weight = double.tryParse(controller.text);
              if (weight != null) {
                WeightLog log = WeightLog(weight, DateTime.now());
                setState(() {
                  data.add(log);
                });
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  List<DataRow> _getTableRows() {
    List<DataRow> rows = [];
    for (WeightLog log in data.reversed.take(8)) {
      rows.add(DataRow(
        cells: <DataCell>[
          DataCell(
            Text(Weight.dateFormat.format(log.logTime)),
          ),
          DataCell(
            Text(log.weightInKgs.toString()),
          ),
        ],
      ));
    }
    return rows;
  }

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
                        addNewWeight(context);
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
                        label: Text("Date"),
                      ),
                      DataColumn(
                        label: Text("Weight (kg)"),
                      ),
                    ],
                    rows: _getTableRows(),
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
