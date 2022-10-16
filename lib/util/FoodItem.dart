class FoodItem {
  // Always per 100g
  final String name;
  final double kcal;
  final double carb;
  final double protein;
  final double fat;
  final double portion;

  FoodItem(
      this.name, this.kcal, this.carb, this.protein, this.fat, this.portion);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'kcal': kcal,
      'carb': carb,
      'protein': protein,
      'fat': fat,
      'portion': portion,
    };
  }

  String printMacros(double portion) {
    return "kCal: ${kcal == -1 ? "N/A" : _toPrecision(kcal * (portion / 100))}, Carbs: ${carb == -1 ? "N/A" : _toPrecision(carb * (portion / 100))}, Protein: ${protein == -1 ? "N/A" : _toPrecision(protein * (portion / 100))}, Fat: ${fat == -1 ? "N/A" : _toPrecision(fat * (portion / 100))}";
  }

  String _toPrecision(double value) {
    return value.toStringAsFixed(2);
  }

  @override
  String toString() {
    return 'FoodItem{name: $name, kcal: $kcal, carb: $carb, protein: $protein, fat: $fat, portion: $portion}';
  }
}
