import 'dart:io';

import 'package:appli_drive_mobile/enums/app_preferences_key.dart';
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

    int currentVersion = await _preferencesService.getInt(AppPreferenceKey.dbVersion) ?? -1;
    int newVersion = 1;

    if (currentVersion < newVersion) {
      if (await File(path).exists()) {
        await deleteDatabase(path);
      }
      await _preferencesService.setInt(AppPreferenceKey.dbVersion, newVersion);
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

  Future<Appmon?> getAppmonByCode(String code, {bool ignoreRevealedField = false}) async {
    String revealedCondiction = '';
    if(!ignoreRevealedField) {
      revealedCondiction = 'AND appmon.revealed = 1';
    }
    final db = await database;
    String sql = '''
      SELECT 
        appmon.inner_id AS id, appmon.code_text, appmon.name, appmon.app, appmon.power, appmon.color_1, appmon.color_2,
        appmon.ability, appmon.attack, appmon.defense, appmon.energy, appmon.resistance, appmon.image_size,
        grade.id AS grade_id, grade.name AS grade_name, 
        type.id AS type_id, type.name AS type_name, 
        fusion.id AS fusion_id, fusion.appmon_base_1, fusion.appmon_base_2
      FROM appmon
      INNER JOIN type ON appmon.type_id = type.id
      INNER JOIN grade ON appmon.grade_id = grade.id
      LEFT JOIN fusion ON appmon.fusion_id = fusion.id
        WHERE appmon.code_text = ? $revealedCondiction;
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
        WHERE appmon.revealed = 1 AND grade.id <= ?
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
      whereClause = 'AND appmon.inner_id IN ($placeholders)';
      whereArgs = ids;
    }

    String sql = '''
      SELECT 
        appmon.inner_id AS id, appmon.name AS name, appmon.code_text AS code,
        grade.name AS gradeName 
      FROM appmon
      INNER JOIN grade ON appmon.grade_id = grade.id
        WHERE appmon.revealed = 1 $whereClause
      ORDER BY grade.id, appmon.name;
    ''';

    return await db.rawQuery(sql, whereArgs);
  }

  Future<Appmon> getSevenCodeInfo(String code) async {
    final db = await database;
    String sql = '''
      SELECT 
        seven_code.inner_id AS id, seven_code.inner_id AS code_text, seven_code.name, seven_code.app, seven_code.power, 
        0 AS image_size,
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

  Future<void> resetRevealedToZero() async {
    final db = await database;
    await db.update(
      'appmon',
      {'revealed': 0},
    );
  }

  Future<void> setRevealedAppmonsForIds(List<String> ids) async {
    if (ids.isEmpty) return;

    final db = await database;
    final idsString = ids.map((_) => '?').join(', ');
    await db.rawUpdate(
      'UPDATE appmon SET revealed = 1 WHERE inner_id IN ($idsString)',
      ids,
    );
  }
}
