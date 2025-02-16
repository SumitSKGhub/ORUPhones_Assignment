
import 'package:flutter/material.dart';
import 'package:oruphones/ui/bottomsheets/filter_view_model.dart';
import 'package:oruphones/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class FilterBottomView extends StatelessWidget {
  final HomeViewModel homeViewModel;

  const FilterBottomView({super.key, required this.homeViewModel});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FilterViewModel>.reactive(
      onViewModelReady: (model) => model.getFilter() ,
      viewModelBuilder: () => FilterViewModel(),
      builder: (context, model, child) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child:
        Column(
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
                            itemCount: model.categories.length,
                            itemBuilder: (context, index) {
                              // String category = model.filterOptions.keys.elementAt(index);
                              //
                              // return ListTile(
                              //   title: Text(category),
                              //   selected: model.selectedCategory == category,
                              //   onTap: () => model.setCategory(category),
                              // );

                              return GestureDetector(
                                onTap: () {
                                  model.selectedCategory =
                                      model.categories[index];
                                  model.notifyListeners();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 8),
                                  color: model.selectedCategory ==
                                          model.categories[index]
                                      ? Colors.amber
                                      : Colors.transparent,
                                  child: Text(
                                    model.categories[index],
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
                          child:

                              ListView(
                                children: model.filterOptions[model.selectedCategory]!.map((option) =>
                                    CheckboxListTile(
                                  title: Text(option),
                                    value: model.selectedFilters[option] ?? false,
                                    onChanged: (value) => model.toggleFilter(option),
                                )).toList(),
                              ),

                          // model.filterOptions
                          //         .containsKey(model.selectedCategory)
                          //     ? ListView(
                          //         children:
                          //           model.filterOptions[model.selectedCategory]!.map((option){
                          //             return CheckboxListTile(
                          //               value: model.selectedFilters[option] ?? false,
                          //                 onChanged: (value){
                          //                   model.selectedFilters[option] = value!;
                          //                 } ,
                          //               title: Text(option),
                          //               secondary: Icon(Icons.info_outline),
                          //             );
                          //           }).toList(),
                          //       )
                          //     : Center(
                          //         child: Text(
                          //           "No options available",
                          //           style: TextStyle(
                          //               fontSize: 16, fontWeight: FontWeight.w500),
                          //         ),
                          //       ),
                        )
                        )
                      ],
                    )
                    ),


                    Padding(padding:  EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(onPressed: (){
                            model.clearFilters();
                          }, child: Text("Clear All",
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
                              homeViewModel.products.clear();
                              // homeViewModel.fetchProducts(isRefresh: true);
                              model.applyFilters(1, "");
                              homeViewModel.notifyListeners();
                              Navigator.pop(context);
                              // print("Selected Filters: $model.selectedFilters");
                            },
                            child: const Text("Apply", style: TextStyle(fontSize: 16)),
                          )
                        ],
                      ),
                    )
                  ],
        )
        );
      }

    );
  }
}
