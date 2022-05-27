// ignore_for_file: non_constant_identifier_names, duplicate_ignore, unused_field, unused_import, constant_identifier_names

import 'dart:ffi';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _dbName = "myDatabase.db";
  static const _dbversion = 1;
  static const _tableName = "myTable";

  static const ColumnId = "id";
  static const columnName = "name";

  DatabaseHelper._privateconstructer();
  static final DatabaseHelper instance = DatabaseHelper._privateconstructer();

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
    await db.execute('''
CREATE TABLE $_tableName($ColumnId INTEGER PRIMARY KEY,$columnName TEXT)
''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future queryall() async {
    Database db = await instance.database;
    return db.query(_tableName);
  }

  Future update(int id) async {
    Database db = await instance.database;
    return db.update(_tableName, {"name": "neel"},
        where: '$ColumnId = ?', whereArgs: [id]);
  }

  Future delete(int id) async {
    Database db = await instance.database;
    return db.delete(_tableName, where: '$ColumnId = ?', whereArgs: [id]);
  }
}
