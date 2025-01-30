class TypeAppmon {
  final int id;
  final String name;

  TypeAppmon({
    required this.id,
    required this.name,
  });

  factory TypeAppmon.fromMap(Map<String, dynamic> map) {
    return TypeAppmon(
      id: map['type_id'],
      name: map['type_name'],
    );
  }
}
