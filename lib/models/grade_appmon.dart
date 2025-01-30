class GradeAppmon {
  final int id;
  final String name;

  GradeAppmon({
    required this.id,
    required this.name,
  });

  factory GradeAppmon.fromMap(Map<String, dynamic> map) {
    return GradeAppmon(
      id: map['grade_id'],
      name: map['grade_name'],
    );
  }
}
