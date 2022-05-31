// ignore_for_file: constant_identifier_names, unused_field

import 'dart:io';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sql_databse_demo/employee_model.dart';

class DatabaseHelper {
  static const _dbName = "mydatabase.db";
  static const _dbversion = 1;
  static const _tableName = "myTable";

  static const ColumnId = "id";
  static const ColumnName = "name";
  static const columnEmail = "email";
  static const ColumnSalary = "salary";
  static const columnMobilenumber = "mobileNumber";

  // static final DatabaseHelper instance = DatabaseHelper._privateconstructer();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initiateDatabase();
    return _database!;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbversion, onCreate: _oncreate);
  }

  Future _oncreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $_tableName($ColumnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnMobilenumber TEXT NOT NULL, $columnEmail TEXT NOT NULL UNIQUE, $ColumnName TEXT NOT NULL, $ColumnSalary TEXT NOT NULL);''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert(_tableName, row);
  }

  Future update(EmployeeModel employeeModel) async {
    Database db = await database;
    return await db.update(
      _tableName,
      employeeModel.toMap(),
      where: '$ColumnId = ?',
      whereArgs: [employeeModel.id],
    );
  }

  Future delete(int id) async {
    Database db = await database;
    return db.delete(
      _tableName,
      where: '$ColumnId = ?',
      whereArgs: [id],
    );
  }

  Future<List<EmployeeModel>> getAllRecordFromDB() async {
    Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return EmployeeModel(
        id: maps[i]['id'],
        email: maps[i]['email'],
        mobileNumber: maps[i]['mobileNumber'],
        name: maps[i]['name'],
        salary: maps[i]['salary'],
      );
    });
  }
}
