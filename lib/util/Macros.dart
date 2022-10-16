class Macros {
  double cals;
  double carb;
  double protein;
  double fat;

  Macros(this.cals, this.carb, this.protein, this.fat);

  Macros.empty()
      : cals = 0,
        carb = 0,
        protein = 0,
        fat = 0;

  @override
  String toString() {
    return 'Macros{cals: $cals, carb: $carb, protein: $protein, fat: $fat}';
  }
}
