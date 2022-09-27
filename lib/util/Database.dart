import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'WeightLog.dart';

class NutritionDB {
  Future<Database> initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      join(await getDatabasesPath(), 'nutrition_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE weight_log(date TEXT PRIMARY KEY, weight REAL)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertWeightLog(Database db, WeightLog weightLog) async {
    await db.insert(
      'weight_log',
      weightLog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<WeightLog>> weightLogs(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query('weight_log');

    return List.generate(maps.length, (i) {
      return WeightLog(maps[i]['weight'], DateTime.parse(maps[i]['date']));
    });
  }

  Future<int> removeWeightLog(Database db, WeightLog weightLog) async {
    return await db.delete("weight_log",
        where: 'date = ?', whereArgs: [weightLog.date.toIso8601String()]);
  }
}
