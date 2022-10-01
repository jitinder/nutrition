class WeightLog {
  final double weight;
  final DateTime date;

  WeightLog(this.weight, this.date);

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'weight': weight,
    };
  }

  @override
  String toString() {
    return 'WeightLog{date: $date, weight: $weight}';
  }
}
