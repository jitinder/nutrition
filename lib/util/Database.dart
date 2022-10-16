import 'package:flutter/widgets.dart';
import 'package:nutrition/util/Macros.dart';
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
      onUpgrade: (db, v1, v2) {
        return db.execute(
          'CREATE TABLE macros_log(date TEXT PRIMARY KEY, cals REAL, carb REAL, protein REAL, fat REAL )',
        );
      },
      version: 2,
    );
  }

  Future<void> insertMacrosLog(Database db, Macros macros) async {
    await db.insert(
      'macros_log',
      macros.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Macros>> macrosLogs(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query('macros_log');
    return List.generate(maps.length, (i) {
      return Macros(DateTime.parse(maps[i]['date']), maps[i]['cals'],
          maps[i]['carb'], maps[i]['protein'], maps[i]['fat']);
    });
  }

  Future<int> removeMacrosLog(Database db, Macros macros) async {
    return await db.delete("macros_log",
        where: 'date = ?', whereArgs: [macros.date.toIso8601String()]);
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
