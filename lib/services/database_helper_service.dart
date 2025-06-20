import 'dart:io';

import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:appli_drive_mobile/services/preferences_service.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  final PreferencesService _preferencesService = PreferencesService();

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

    int currentVersion = await _preferencesService.getInt('db_version') ?? -1;
    int newVersion = 0;

    if (currentVersion < newVersion) {
      if (await File(path).exists()) {
        await deleteDatabase(path);
      }
      await _preferencesService.setInt('db_version', newVersion);
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

  Future<List<Map<String, dynamic>>> getAppmonCodeListToDataCenter({List<String>? ids, bool filterByIds = true}) async {
    final db = await database;

    String whereClause = '';
    List<dynamic> whereArgs = [];

    if (filterByIds && ids != null && ids.isNotEmpty) {
      final placeholders = List.filled(ids.length, '?').join(', ');
      whereClause = 'WHERE appmon.inner_id IN ($placeholders)';
      whereArgs = ids;
    }

    String sql = '''
      SELECT 
        appmon.inner_id AS id, appmon.name AS name, appmon.code_text AS code,
        grade.name AS gradeName 
      FROM appmon
      INNER JOIN grade ON appmon.grade_id = grade.id
        $whereClause
      ORDER BY grade.id, appmon.name;
    ''';

    return await db.rawQuery(sql, whereArgs);
  }

  Future<Appmon> getSevenCodeInfo(String code) async {
    final db = await database;
    String sql = '''
      SELECT 
        seven_code.inner_id AS id, seven_code.inner_id AS code_text, seven_code.name, seven_code.app, seven_code.power, 
        grade.id AS grade_id, grade.name AS grade_name, 
        type.id AS type_id, type.name AS type_name 
      FROM seven_code
      INNER JOIN type ON seven_code.type_id = type.id
      INNER JOIN grade ON seven_code.grade_id = grade.id
        WHERE seven_code.inner_id = ?;
    ''';
    List<Map<String, dynamic>> result = await db.rawQuery(sql, [code]);

    return Appmon.fromMap(result.first);
  }
}
