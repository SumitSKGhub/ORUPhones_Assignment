import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:oruphones/core/models/product_model.dart';
import 'package:stacked/stacked.dart';

class SortViewModel extends BaseViewModel{
  final String baseUrl = "http://40.90.224.241:5000";

  final List<String> sortItem = [
    "Value For Money",
    "Price: High To Low",
    "Price: Low To High",
    "Latest",
    // "Distance",
  ];

  String selectedSort = "Value For Money";

  void updateSort(String sort){
    selectedSort = sort;
    notifyListeners();
  }


  // Future<List<Product>> fetchProducts(int page) async {
  //
  //   Map<String, dynamic> sortOptions = {
  //     "Latest": {"date": -1},
  //     "Value For Money": {},
  //     "Most Viewed": {"views": -1},
  //     "Price High to Low": {"price": -1},
  //     "Price Low to High": {"price": 1},
  //   };
  //
  //   Map<String, dynamic> requestBody ={
  //     "filter": {
  //       "sort": sortOptions[selectedSort] ?? {},
  //       "page" : page
  //     }
  //   };
  //
  //
  //   final response = await http.post(
  //     Uri.parse("$baseUrl/filter"),
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode(requestBody
  //       //     {
  //       //   "filter": {
  //       //     "sort": {},
  //       //     // "priceRange": [40000, 175000],
  //       //     // "condition": ["Like New"],
  //       //     "page": page
  //       //   }
  //       // }
  //     ),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //
  //     if (data["data"] != null && data["data"]["data"] != null) {
  //       List<dynamic> productsList = data["data"]["data"];
  //       print(productsList);
  //       return productsList
  //           .map((element) => Product.fromJson(element))
  //           .toList();
  //     }
  //   }
  //   return [];
  // }
}