import 'package:flutter/material.dart';
import 'package:oruphones/core/models/product_model.dart';
import 'package:oruphones/core/services/product_service.dart';
import 'package:oruphones/locator.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final ProductService _productService = locator<ProductService>();

  List<Product> originalProducts = [];
  List<Product> products = [];

  int adIndex = 1;

  List<String> ads = [
    "assets/images/banners/banner_ad1.png",
    "assets/images/banners/banner_ad2.png"
  ];

  int currentPage = 1;
  bool isLoading = false;
  bool isFetching = false;
  ScrollController scrollController = ScrollController();

  HomeViewModel() {
    scrollController.addListener(_onScroll);
  }

  Future<void> fetchProducts() async {
    isFetching = true;
    notifyListeners();

    List<Product> newProducts =
        await _productService.fetchProducts(currentPage);
    products.addAll(newProducts);

    currentPage++;
    isFetching = false;
    notifyListeners();
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent && !isFetching) {
      currentPage++;
      fetchProducts();
    }
  }
}
