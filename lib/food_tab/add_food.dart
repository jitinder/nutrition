import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrition/util/FoodItem.dart';
import 'package:nutrition/util/constants.dart';
import 'package:openfoodfacts/model/parameter/SearchTerms.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../util/AppBarData.dart';

class AddFoodPopup extends StatefulWidget {
  final String mealName;
  const AddFoodPopup(this.mealName, {Key? key}) : super(key: key);

  @override
  State<AddFoodPopup> createState() => _AddFoodPopupState();
}

class _AddFoodPopupState extends State<AddFoodPopup> {
  TextEditingController searchController = TextEditingController();

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
      );
      print(item);
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
              margin: EdgeInsets.only(bottom: 16),
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
                    child: Icon(CupertinoIcons.barcode_viewfinder),
                    onPressed: () {
                      print("Search by Barcode");
                    },
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: CupertinoTextField(
              placeholder: "Portion Size (g)",
              decoration: BoxDecoration(
                color: Colors.white54,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.white54,
              margin: EdgeInsets.symmetric(vertical: 16),
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(index.toString()),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    thickness: 1,
                    height: 1,
                  );
                },
                itemCount: 2,
              ),
            ),
          ),
          Flexible(
            child: CupertinoButton.filled(
              child: Text("Add"),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
