
import 'package:flutter/material.dart';

class BottomSheetService {

  final List<String> categories = [
    "Location",
    "Distance",
    "Brand",
    "Condition",
    "Storage",
    "Ram",
    "Verification",
    "Warranty"
  ];

  final Map<String, List<String>> filterOptions = {
    "Condition": ["Like New", "Excellent", "Good", "Fair", "Needs Repair"],
    "Storage": ["16 GB", "32 GB", "64 GB", "128 GB"],
    "Ram": ["2 GB", "4 GB", "6 GB", "8 GB"],
    "Warranty": ["Brand Warranty", "Seller Warranty"],
  };

  String selectedCategory = "Condition";
  final Map<String, bool> selectedFilters = {};

  void showCustomBottomSheet(BuildContext context){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height *
                0.75, //a great way to limit height of a widget
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filters",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.close))
                    ],
                  ),
                ),
                Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          color: Colors.grey[200],
                          child: ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  selectedCategory =
                                  categories[index];
                                  // notifyListeners();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 8),
                                  color: selectedCategory ==
                                      categories[index]
                                      ? Colors.amber
                                      : Colors.transparent,
                                  child: Text(
                                    categories[index],
                                    style: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: filterOptions
                                  .containsKey(selectedCategory)
                                  ? ListView(
                                children:
                                filterOptions[selectedCategory]!.map((option){
                                  return CheckboxListTile(
                                    value: selectedFilters[option] ?? false,
                                    onChanged: (value){
                                      selectedFilters[option] = value!;
                                    } ,
                                    title: Text(option),
                                    secondary: Icon(Icons.info_outline),
                                  );
                                }).toList(),
                              )
                                  : Center(
                                child: Text(
                                  "No options available",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                        )
                      ],
                    )
                ),


                Padding(padding:  EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: (){}, child: Text("Clear All",
                        style: TextStyle(
                            color: Colors.amber,fontSize: 16),
                      ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          print("Selected Filters: $selectedFilters");
                        },
                        child: const Text("Apply", style: TextStyle(fontSize: 16)),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

}