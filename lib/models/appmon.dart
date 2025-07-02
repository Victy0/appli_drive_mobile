import 'package:appli_drive_mobile/models/fusion_info.dart';
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
  final FusionInfo? fusionInfo;
  final int ability;
  final int attack;
  final int defense;
  final int energy;
  final int resistance;
  bool? fusioned;
  final String? primaryColor;
  final String? secondaryColor;
  final int imageSize;

  Appmon({
    required this.id,
    required this.code,
    required this.name,
    required this.app,
    required this.power,
    required this.type,
    required this.grade,
    required this.fusionInfo,
    required this.ability,
    required this.attack,
    required this.defense,
    required this.energy,
    required this.resistance,
    this.fusioned,
    this.primaryColor,
    this.secondaryColor,
    required this.imageSize,
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
      fusionInfo: map['fusion_id'] != null ? FusionInfo.fromMap(map) : null,
      ability: map['ability'],
      attack: map['attack'],
      defense: map['defense'],
      energy: map['energy'],
      resistance: map['resistance'],
      fusioned: null,
      primaryColor: map['color_1'],
      secondaryColor: map['color_2'],
      imageSize: map['image_size'],
    );
  }
}
