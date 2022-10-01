class FoodItem {
  // Always per 100g
  final String name;
  final double kcal;
  final double carb;
  final double protein;
  final double fat;

  FoodItem(this.name, this.kcal, this.carb, this.protein, this.fat);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'kcal': kcal,
      'carb': carb,
      'protein': protein,
      'fat': fat,
    };
  }

  @override
  String toString() {
    return 'FoodItem{name: $name, kcal: $kcal, carb: $carb, protein: $protein, fat: $fat}';
  }
}
