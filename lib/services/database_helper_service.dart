import 'dart:io';

import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentVersion = prefs.getInt('db_version') ?? -1;
    int newVersion = 0;

    if (currentVersion < newVersion) {
      if (await File(path).exists()) {
        await deleteDatabase(path);
      }
      await prefs.setInt('db_version', newVersion);
    }

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

  Future<Appmon?> getAppmonByCode(String code) async {
    final db = await database;
    String sql = '''
      SELECT 
        appmon.inner_id AS id, appmon.code_text, appmon.name, appmon.app, appmon.power, 
        grade.id AS grade_id, grade.name AS grade_name, 
        type.id AS type_id, type.name AS type_name, 
        fusion.id AS fusion_id, fusion.appmon_base_1, fusion.appmon_base_2
      FROM appmon
      INNER JOIN type ON appmon.type_id = type.id
      INNER JOIN grade ON appmon.grade_id = grade.id
      LEFT JOIN fusion ON appmon.fusion_id = fusion.id
      WHERE appmon.code_text = ?;
    ''';
    List<Map<String, dynamic>> results = await db.rawQuery(sql, [code]);

    if (results.isNotEmpty) {
      return Appmon.fromMap(results.first);
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getAppmonCodeList(int gradeLevelId) async {
    final db = await database;
    String sql = '''
      SELECT 
        appmon.inner_id AS id, appmon.code_text AS code, 
        grade.name AS gradeName 
      FROM appmon
      INNER JOIN grade ON appmon.grade_id = grade.id
      WHERE grade.id <= ?
      ORDER BY grade.id, appmon.code_text;
    ''';
    return await db.rawQuery(sql, [gradeLevelId]);
  }
}
