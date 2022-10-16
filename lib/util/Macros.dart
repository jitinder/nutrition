class Macros {
  DateTime date;
  double cals;
  double carb;
  double protein;
  double fat;

  Macros(this.date, this.cals, this.carb, this.protein, this.fat);

  Macros.empty()
      : date = DateTime.now(),
        cals = 0,
        carb = 0,
        protein = 0,
        fat = 0;

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'cals': cals,
      'carb': carb,
      'protein': protein,
      'fat': fat,
    };
  }

  @override
  String toString() {
    return 'Macros{date: $date, cals: $cals, carb: $carb, protein: $protein, fat: $fat}';
  }
}
