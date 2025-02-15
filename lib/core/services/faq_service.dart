import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:oruphones/core/models/faq_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FAQService{
  final String baseUrl = "http://40.90.224.241:5000";

  Future<List<FAQ>> fetchFAQs() async {
    final response = await http.get(Uri.parse("$baseUrl/faq"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data is Map<String, dynamic> && data.containsKey("FAQs")) {
        List<dynamic> faqList = data["FAQs"];
        return faqList.map((faq) => FAQ.fromJson(faq)).toList();
      }
    }

    throw Exception("Failed to load FAQs");

  }
}