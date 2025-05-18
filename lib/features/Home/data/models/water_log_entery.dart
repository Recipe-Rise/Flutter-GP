class WaterLogEntry {
  final String type; // Glass, Bottle, Mug, etc.
  final int amount;
  final DateTime time;

  WaterLogEntry({
    required this.type,
    required this.amount,
    required this.time,
  });

  WaterLogEntry copyWith({
    String? type,
    int? amount,
    DateTime? time,
  }) {
    return WaterLogEntry(
      type: type ?? this.type,
      amount: amount ?? this.amount,
      time: time ?? this.time,
    );
  }
}