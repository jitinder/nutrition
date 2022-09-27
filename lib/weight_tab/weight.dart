import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutrition/util/Database.dart';
import 'package:nutrition/util/WeightLog.dart';
import 'package:sqflite/sqflite.dart';

import '../util/DataContainer.dart';

class Weight extends StatefulWidget {
  const Weight({Key? key}) : super(key: key);
  static DateFormat dateFormat = DateFormat('dd MMM yyyy');

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  List<WeightLog> data = [];
  var database;

  @override
  void initState() {
    super.initState();
    NutritionDB().initDB().then((db) {
      database = db;
      _getWeightLogsFromDB(db);
    });
  }

  void _getWeightLogsFromDB(Database db) async {
    List<WeightLog> weightLogs = await NutritionDB().weightLogs(db);
    setState(() {
      data = weightLogs;
    });
  }

  void _addWeightLogToDB(Database db, WeightLog weightLog) async {
    await NutritionDB().insertWeightLog(db, weightLog);
    _getWeightLogsFromDB(db);
  }

  void _removeWeightLogFromDB(Database db, WeightLog weightLog) async {
    await NutritionDB().removeWeightLog(db, weightLog);
    _getWeightLogsFromDB(db);
  }

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
                _addWeightLogToDB(database, log);
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _deleteDialog(BuildContext context, WeightLog log) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        title: Text("Delete Log"),
        content: Text("Do you want to delete this log?"),
        actions: [
          CupertinoDialogAction(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: Text("Delete"),
            isDestructiveAction: true,
            isDefaultAction: true,
            onPressed: () {
              _removeWeightLogFromDB(database, log);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  List<DataRow> _getTableRows(
    BuildContext context,
  ) {
    List<DataRow> rows = [];
    for (WeightLog log in data.reversed.take(8)) {
      rows.add(DataRow(
        onLongPress: () {
          _deleteDialog(context, log);
        },
        cells: <DataCell>[
          DataCell(
            Text(Weight.dateFormat.format(log.date)),
          ),
          DataCell(
            Text(log.weight.toString()),
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
                        domainFn: (WeightLog log, _) => log.date,
                        measureFn: (WeightLog log, _) => log.weight,
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
                    rows: _getTableRows(context),
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
