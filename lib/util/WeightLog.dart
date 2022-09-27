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

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'WeightLog{date: $date, weight: $weight}';
  }
}
