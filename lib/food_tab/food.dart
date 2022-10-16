import 'package:flutter/material.dart';
import 'package:nutrition/util/FoodItem.dart';
import 'package:nutrition/util/Macros.dart';

import '../util/DataContainer.dart';
import '../util/constants.dart';
import 'add_food.dart';

class Food extends StatefulWidget {
  const Food({Key? key}) : super(key: key);

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {
  Map<String, List<FoodItem>> mealsMap = {};
  Macros targetMacros = Macros(2200, 200, 200, 200);
  Macros currentMacros = Macros.empty();

  double _keyboardHeight(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      return MediaQuery.of(context).viewInsets.bottom - 100;
    }
    return 0;
  }

  void _calculateCurrentMacros() {
    Macros tempMacros = Macros.empty();
    for (String meal in mealNames) {
      for (FoodItem item in mealsMap[meal] ?? []) {
        tempMacros.cals += item.kcal;
        tempMacros.carb += item.carb;
        tempMacros.protein += item.protein;
        tempMacros.fat += item.fat;
      }
    }
    setState(() {
      currentMacros = tempMacros;
    });
  }

  void _addToMeal(String mealName, FoodItem item) {
    if (!mealsMap.containsKey(mealName)) {
      mealsMap[mealName] = [];
    }
    setState(() {
      mealsMap[mealName]?.add(item);
    });
    _calculateCurrentMacros();
  }

  void _showAddFoodBox(BuildContext context, String mealName) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => Container(
              height: 500 + _keyboardHeight(context), // Keyboard movement
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: AddFoodPopup(mealName, _addToMeal),
            ));
  }

  Widget _macrosBox(String name, Color color, int currentValue, int maxValue) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$currentValue",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.black),
                textScaleFactor: 0.7,
              ),
              Text(
                " / $maxValue",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.black54),
                textScaleFactor: 0.6,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: LinearProgressIndicator(
              value: currentValue / maxValue,
              color: color,
              backgroundColor: color.withOpacity(0.3),
            ),
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(name),
          ),
        ],
      ),
    );
  }

  Widget _mealBox(String mealName) {
    List<FoodItem> items = mealsMap[mealName] ?? [];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              mealName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ActionChip(
              elevation: 0,
              label: Icon(
                Icons.add,
              ),
              onPressed: () {
                _showAddFoodBox(context, mealName);
              },
            ),
          ],
        ),
        Expanded(
          flex: 4,
          child: Align(
            alignment: Alignment.topLeft,
            child: DataTable(
              headingTextStyle: Theme.of(context).textTheme.titleSmall,
              dataTextStyle: Theme.of(context).textTheme.bodyMedium,
              horizontalMargin: 0,
              headingRowHeight: 30,
              dataRowHeight: 40,
              dividerThickness: 0,
              columnSpacing: 10,
              columns: const <DataColumn>[
                DataColumn(
                  label: Text("Item"),
                ),
                DataColumn(
                  label: Text("Kcals"),
                  numeric: true,
                ),
                DataColumn(
                  label: Text("C"),
                  numeric: true,
                ),
                DataColumn(
                  label: Text("P"),
                  numeric: true,
                ),
                DataColumn(
                  label: Text("F"),
                  numeric: true,
                ),
              ],
              rows: items
                  .map(
                    (item) => DataRow(
                      cells: <DataCell>[
                        DataCell(
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 150,
                            ),
                            child: Text(
                              item.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(item.kcal.toStringAsFixed(1)),
                        ),
                        DataCell(
                          Text(item.carb.toStringAsFixed(1)),
                        ),
                        DataCell(
                          Text(item.protein.toStringAsFixed(1)),
                        ),
                        DataCell(
                          Text(item.fat.toStringAsFixed(1)),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  double _getMealBoxHeight(String meal) {
    int items = mealsMap[meal]?.length ?? 0;
    return (125 + (40 * items)).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        dataContainer(
          300,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.whatshot,
                color: Colors.deepOrange,
              ),
              const Text("Calories"),
              Center(
                child: Text(
                  currentMacros.cals.toStringAsFixed(0),
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.black,
                      ),
                  textScaleFactor: 1.5,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _macrosBox(
                      "Carbohydrate",
                      Colors.teal,
                      currentMacros.carb.round(),
                      targetMacros.carb.round(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: _macrosBox(
                      "Protein",
                      Colors.blueAccent,
                      currentMacros.protein.round(),
                      targetMacros.protein.round(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: _macrosBox(
                      "Fat",
                      Colors.indigoAccent,
                      currentMacros.fat.round(),
                      targetMacros.fat.round(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        ...mealNames
            .map(
              (meal) => dataContainer(_getMealBoxHeight(meal), _mealBox(meal)),
            )
            .toList(),
      ],
    );
  }
}
