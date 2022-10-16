import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrition/util/FoodItem.dart';
import 'package:nutrition/util/constants.dart';
import 'package:openfoodfacts/model/parameter/SearchTerms.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../util/AppBarData.dart';

class AddFoodPopup extends StatefulWidget {
  final String mealName;
  final Function(String, FoodItem) addToMeal;
  const AddFoodPopup(this.mealName, this.addToMeal, {Key? key})
      : super(key: key);

  @override
  State<AddFoodPopup> createState() => _AddFoodPopupState();
}

class _AddFoodPopupState extends State<AddFoodPopup> {
  TextEditingController searchController = TextEditingController();
  TextEditingController portionController =
      TextEditingController(text: "100.0");
  double portionSize = 100.0;
  List<FoodItem> foodItems = [];

  _getOpenFoodItem(ProductSearchQueryConfiguration configuration) async {
    SearchResult result =
        await OpenFoodAPIClient.searchProducts(TEST_USER, configuration);
    result.products?.forEach((product) {
      FoodItem item = FoodItem(
        product.productName ?? "No Name",
        product.nutriments?.energyKcal100g ?? -1,
        product.nutriments?.carbohydrates ?? -1,
        product.nutriments?.proteins ?? -1,
        product.nutriments?.fat ?? -1,
        100.0,
      );
      setState(() {
        foodItems.add(item);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Flexible(
            child: Container(
              child: titlePill("Add Food to ${widget.mealName}"),
              margin: const EdgeInsets.only(bottom: 16),
            ),
          ),
          Flexible(
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: CupertinoSearchTextField(
                    controller: searchController,
                    placeholder: "Search by item name",
                    onSubmitted: (text) {
                      print("Searching for $text");
                      List<Parameter> params = <Parameter>[
                        SearchTerms(
                          terms: [text],
                        ),
                        const PageSize(size: 10),
                      ];
                      ProductSearchQueryConfiguration configuration =
                          ProductSearchQueryConfiguration(
                              parametersList: params,
                              fields: [
                                ProductField.NAME,
                                ProductField.NUTRIMENTS,
                              ],
                              language: OpenFoodFactsLanguage.ENGLISH);
                      _getOpenFoodItem(configuration);
                    },
                  ),
                ),
                Expanded(
                  child: CupertinoButton(
                    child: const Icon(CupertinoIcons.barcode_viewfinder),
                    onPressed: () {
                      print("Search by Barcode");
                    },
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                const Expanded(
                  child: FittedBox(
                    child: Text("Portion Size (g): "),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CupertinoTextField(
                    controller: portionController,
                    decoration: const BoxDecoration(
                      color: Colors.white54,
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) {
                      setState(() {
                        portionSize =
                            double.tryParse(portionController.text) ?? 100.0;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              color: Colors.white54,
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  FoodItem item = foodItems[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.printMacros(
                        double.tryParse(portionController.text) ?? 0)),
                    onTap: () {
                      widget.addToMeal(widget.mealName, item);
                      Navigator.pop(context);
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    thickness: 1,
                    height: 1,
                  );
                },
                itemCount: foodItems.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
