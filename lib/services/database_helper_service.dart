import 'dart:io';

import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'appli_drive_database.db');

    if (!await File(path).exists()) {
      ByteData data = await rootBundle.load("assets/appli_drive_database.db");
      List<int> bytes = data.buffer.asUint8List();
      await File(path).writeAsBytes(bytes);
    }

    return await openDatabase(
      path,
      version: 1,
      readOnly: false,
    );
  }

  Future<List<Map<String, dynamic>>> getAppmons() async {
    final db = await database;
    return await db.query('appmon');
  }

  Future<List<Appmon>> getAppmonByCode(String code) async {
    final db = await database;
    String sql = '''
      SELECT 
        appmon.id, appmon.code_text, appmon.name, appmon.app, appmon.power, 
        grade.id AS grade_id, grade.name AS grade_name, 
        type.id AS type_id, type.name AS type_name
      FROM appmon
      INNER JOIN type ON appmon.type_id = type.id
      INNER JOIN grade ON appmon.grade_id = grade.id
      WHERE appmon.code_text = ?;
    ''';
    List<Map<String, dynamic>> results = await db.rawQuery(sql, [code]);

    return results.map((map) => Appmon.fromMap(map)).toList();
  }
}
