class FusionInfo {
  final String id;
  final String appmonBase1;
  final String appmonBase2;

  FusionInfo({
    required this.id,
    required this.appmonBase1,
    required this.appmonBase2,
  });

  factory FusionInfo.fromMap(Map<String, dynamic> map) {
    return FusionInfo(
      id: map['fusion_id'],
      appmonBase1: map['appmon_base_1'],
      appmonBase2: map['appmon_base_2'],
    );
  }
}
