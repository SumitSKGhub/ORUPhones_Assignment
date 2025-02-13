import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:oruphones/core/models/product_model.dart';

class ProductService{
  final String baseUrl = "http://40.90.224.241:5000";

  Future<List<Product>> fetchProducts(int page) async {
    final response = await http.post(Uri.parse("$baseUrl/filter"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "filter": {
        // "priceRange": [40000, 175000],
        // "condition": ["Needs Repair"],
        "page": page
      }
    }),
    );

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);

      if(data["data"] != null && data["data"]["data"] != null){
        List<dynamic> productsList = data["data"]["data"];
        print(productsList);
        return productsList.map((element)=> Product.fromJson(element)).toList();
      }

    }
    return [];
  }
}