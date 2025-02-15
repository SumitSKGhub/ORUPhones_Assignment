import 'package:flutter/material.dart';
import 'package:oruphones/ui/views/bottomsheets/sort_view_model.dart';
import 'package:oruphones/ui/views/filtered_view.dart';
import 'package:oruphones/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SortBottomView extends StatelessWidget {
  // final Function(String?) onApply;
  final HomeViewModel homeViewModel;

  const SortBottomView({super.key, required this.homeViewModel});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SortViewModel>.reactive(
        viewModelBuilder: () => SortViewModel(),
        builder: (context, model, child) {
          return SizedBox(
              // color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16.0, left: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sort",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.close))
                      ],
                    ),
                  ),
                  Divider(),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(top: 6.0),
                    child: ListView.builder(
                      itemCount: model.sortItem.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            model.selectedSort = model.sortItem[index];
                            model.notifyListeners();
                          },
                          child: Container(
                            height: 60,
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                            color: model.selectedSort == model.sortItem[index]
                                ? Color(0xFFFEFAEF)
                                : Colors.transparent,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    model.sortItem[index],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Radio(
                                  activeColor: Colors.amber,
                                  value: model.sortItem[index],
                                  groupValue: model.selectedSort,
                                  onChanged: (value) {
                                    model.selectedSort = value!;
                                    model.notifyListeners();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              // model.updateSort(null);
                            },
                            child: Text(
                              "Clear",
                              style:
                                  TextStyle(color: Colors.amber, fontSize: 16),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              backgroundColor: Colors.amber,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            onPressed: () {
                              homeViewModel.products.clear();
                              homeViewModel.selectedSort = model.selectedSort;
                              print("Sort: "+homeViewModel.selectedSort);
                              homeViewModel.fetchProducts(isRefresh: true);
                              homeViewModel.notifyListeners();
                              Navigator.pop(context);
                              // Navigator.pushNamed(context, '/filtered');
                              // onApply(model.selectedSort);
                              // print("Selected Filters: $model.selectedFilters");
                            },
                            child: const Text("Apply",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ));
        });
  }
}
