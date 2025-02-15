import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:oruphones/core/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductService {
  final String baseUrl = "http://40.90.224.241:5000";

  final List<String> categories = [
    "Brand",
    "Condition",
    "Storage",
    "Ram",
    "Verification",
    "Warranty",
    "Price Range"
    // "Location",
    // "Distance",
    // "Brand",
    // "Condition",
    // "Storage",
    // "Ram",
    // "Verification",
    // "Warranty"
  ];

  final Map<String, List<String>> filterOptions = {
    "Brand": ["Apple","Samsung","Google","OnePlus","Xiaomi"],
    "Condition": ["Like New", "Excellent", "Good", "Fair", "Needs Repair"],
    "Storage": ["8 GB","16 GB", "32 GB", "64 GB", "128 GB","256 GB","512 GB","1 TB"],
    "Ram": ["2 GB","3 GB", "4 GB","5 GB", "6 GB","7 GB", "8 GB", "12 GB", "16 GB"],
    "Verification": ["Verified Only"],
    "Warranty": ["Brand Warranty", "Seller Warranty"],
    "Price Range": [""]
    // "Condition": ["Like New", "Excellent", "Good", "Fair", "Needs Repair"],
    // "Storage": ["16 GB", "32 GB", "64 GB", "128 GB"],
    // "Ram": ["2 GB", "4 GB", "6 GB", "8 GB"],
    // "Warranty": ["Brand Warranty", "Seller Warranty"],
  };

  String selectedCategory = "Condition";
  final Map<String, bool> selectedFilters = {};

  Future<List<Product>> fetchProducts(int page, String selectedSort,Map<String, dynamic> selectedFilters) async {
    Map<String, dynamic> sortOptions = {
      "Latest": {"date": -1},
      "Value For Money": {}, // Empty for value for money
      // "Most Viewed": {"views": -1},
      "Price: High To Low": {"price": -1},
      "Price: Low To High": {"price": 1},
    };

    Map<String, dynamic> filterData = {
      "make": selectedFilters["Brand"] ?? [],
      "condition": selectedFilters["Condition"] ?? [],
      "storage": selectedFilters["Storage"] ?? [],
      "ram": selectedFilters["Ram"] ?? [],
      "warranty": selectedFilters["Warranty"] ?? [],
      "verified": selectedFilters.containsKey("Verification") && selectedFilters["Verification"]!.isNotEmpty,
    };

    Map<String, dynamic> requestBody = {
      "filter": {
        "sort": sortOptions[selectedSort] ?? {}, // Insert selected sort option
        ...filterData,
        "page": page
      }
    };

    final response = await http.post(
      Uri.parse("$baseUrl/filter"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
          requestBody
          //     {
          //   "filter": {
          //     "sort": {
          //       "price": 1
          //       // "priceRange": [40000, 175000],
          //       // "condition": ["Like New"],
          //     },
          //
          //     "page": page
          //   }
          // }
          ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data["data"] != null && data["data"]["data"] != null) {
        List<dynamic> productsList = data["data"]["data"];
        print(productsList);
        return productsList
            .map((element) => Product.fromJson(element))
            .toList();
      }
    }
    return [];
  }


  Future<void> like(String listingId,bool like) async {

    final prefs = await SharedPreferences.getInstance();
    String? csrfToken = prefs.getString("csrf_token");
    String? authCookie = prefs.getString("auth_cookie");

    final response = await http.post(
      Uri.parse("$baseUrl/favs"),
      headers: {
        "Content-Type": "application/json",
        "X-Csrf-Token": csrfToken ?? "",
        "Cookie": authCookie ?? "",
      },
      body: jsonEncode(
          {
            "listingId": listingId,
            "isFav": like
      }
      ),
    );

    if(response.statusCode == 200){
      print("Response: ");
      print(await response.body);
      final data = jsonDecode(response.body);
      print(data["success"]);
      if(data["success"]){
        print("Got");
        if(!favList.contains(listingId)){
          favList.add(listingId);
        }
        prefs.setStringList("favList", favList);
        print(favList);
      }
    }
    else{
      print("Response: ");
      print(response.reasonPhrase);
    }

  }

  Future<List<String>> getFavList() async{
    final prefs = await SharedPreferences.getInstance();

    print("pref List");
    print(prefs.getStringList("favList"));

    if(prefs.getStringList("favList")!=null){
      favList = prefs.getStringList("favList")!.toList();
    }

    return favList;
  }

  List<String> favList = [];

}
