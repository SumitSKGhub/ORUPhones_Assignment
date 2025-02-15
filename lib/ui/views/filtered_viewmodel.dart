//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:oruphones/core/models/product_model.dart';
// import 'package:oruphones/core/services/bottom_sheet_service.dart';
// import 'package:oruphones/core/services/product_service.dart';
// import 'package:oruphones/locator.dart';
// import 'package:oruphones/ui/views/bottomsheets/filter_bottomsheet_view.dart';
// import 'package:oruphones/ui/views/bottomsheets/sort_bottomsheet_view.dart';
// import 'package:oruphones/ui/views/home/home_viewmodel.dart';
// import 'package:stacked/stacked.dart';
//
// class FilteredViewModel extends BaseViewModel{
//
//   final ProductService _productService = locator<ProductService>();
//   final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
//
//   List<Product> originalProducts = [];
//   List<Product> products = [];
//
//   String selectedSort = "Price High to Low";
//
//   int adIndex = 1;
//
//   List<String> ads = [
//     "assets/images/banners/banner_ad1.png",
//     "assets/images/banners/banner_ad2.png"
//   ];
//
//   int currentPage = 1;
//   bool isLoading = false;
//   bool isFetching = false;
//   ScrollController scrollController = ScrollController();
//
//   HomeViewModel() {
//     scrollController.addListener(_onScroll);
//   }
//
//   Future<void> fetchProducts({bool isRefresh = false}) async {
//     Map<String, List<String>> selectedFilterMap = {};
//
//     if(isRefresh){
//       currentPage = 1;
//       products.clear();
//     }
//     isFetching = true;
//     notifyListeners();
//
//     List<Product> newProducts =
//     await _productService.fetchProducts(currentPage,selectedSort,selectedFilterMap);
//     products.addAll(newProducts);
//
//     currentPage++;
//     isFetching = false;
//     notifyListeners();
//   }
//
//   void _onScroll() {
//     if (scrollController.position.pixels ==
//         scrollController.position.maxScrollExtent &&
//         !isFetching) {
//       currentPage++;
//       fetchProducts();
//     }
//   }
//
//   // void showSortBottomSheet(BuildContext context, HomeViewModel homeViewModel){
//   //   showModalBottomSheet(
//   //     context: context,
//   //     isScrollControlled: true,
//   //     shape: RoundedRectangleBorder(
//   //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//   //     ),
//   //     builder: (context) => SortBottomView(homeViewModel: homeViewModel,),
//   //   );
//   // }
//
//   void showFilterBottomSheet(BuildContext context) {
//
//     // _bottomSheetService.showCustomBottomSheet(context);
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) => FilterBottomView(),
//     );
//   }
//
// }