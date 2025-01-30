import 'package:appli_drive_mobile/models/grade_appmon.dart';
import 'package:appli_drive_mobile/models/type_appmon.dart';

class Appmon {
  final String id;
  final String code;
  final String name;
  final String app;
  final int power;
  final TypeAppmon type;
  final GradeAppmon grade;

  Appmon({
    required this.id,
    required this.code,
    required this.name,
    required this.app,
    required this.power,
    required this.type,
    required this.grade,
  });

  factory Appmon.fromMap(Map<String, dynamic> map) {
    return Appmon(
      id: map['id'],
      code: map['code_text'],
      name: map['name'],
      app: map['app'],
      power: map['power'],
      type: TypeAppmon.fromMap(map),
      grade: GradeAppmon.fromMap(map),
    );
  }
}
