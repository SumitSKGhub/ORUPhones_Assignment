import 'package:flutter/material.dart';
import 'package:oruphones/core/models/product_model.dart';
import 'package:oruphones/core/services/auth_service.dart';
import 'package:oruphones/core/services/bottom_sheet_service.dart';
import 'package:oruphones/core/services/product_service.dart';
import 'package:oruphones/locator.dart';
import 'package:oruphones/ui/views/auth/login_view.dart';
import 'package:oruphones/ui/views/auth/verify_otp_view.dart';
import 'package:oruphones/ui/views/bottomsheets/filter_bottomsheet_view.dart';
import 'package:oruphones/ui/views/bottomsheets/sort_bottomsheet_view.dart';
import 'package:oruphones/ui/views/bottomsheets/sort_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final ProductService _productService = locator<ProductService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final AuthService _authService = locator<AuthService>();

  List<Product> originalProducts = [];
  List<Product> products = [];
  List<String> favList = []; //as Future<List<String>>;

  bool isLoggedIn = false;
  bool isReady = false;

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
    fetchFavList();
    login();
  }

  String selectedSort = "Value For Money";

  void launchOTPBottomSheet(BuildContext contextA) {
    // showBottomSheet(
    //     context: context,
    //
    //     builder: (context) =>
    //         Padding(padding: EdgeInsets.all(16.0),
    //             child: LoginView(
    //             isBottomSheet: true,contextHome: context,homeViewModel: this,
    //         ),
    //         )
    // );
    showModalBottomSheet(
        context: contextA,
        useSafeArea: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) => Padding(
              padding: EdgeInsets.all(16.0),
              child: LoginView(
                isBottomSheet: true,
                contextHome: contextA,
                homeViewModel: this,
              ),
            ));
  }

  void launchOTPVerifyBottomSheet(BuildContext context, String phoneNumber) {
    showModalBottomSheet(
        context: context,
        useSafeArea: true,
        builder: (context) => Padding(
              padding: EdgeInsets.all(16.0),
              child: VerifyOtpView(
                isBottomSheet: true,
                phoneNumber: phoneNumber,
              ),
            ));
  }

  void login() async {
    isLoggedIn = await _authService.checkAuthStatus();
    notifyListeners();
  }

  Future<void> fetchProducts({bool isRefresh = false}) async {
    Map<String, List<String>> selectedFilterMap = {};

    if (isRefresh) {
      currentPage = 1;
      products.clear();
    }

    isFetching = true;
    notifyListeners();

    List<Product> newProducts = await _productService.fetchProducts(
        currentPage, selectedSort, selectedFilterMap);
    products.addAll(newProducts);

    currentPage++;
    isFetching = false;
    notifyListeners();
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isFetching) {
      currentPage++;
      fetchProducts();
    }
  }

  void showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SortBottomView(
        homeViewModel: this,
      ),
    );
  }

  void showFilterBottomSheet(BuildContext context) {
    // _bottomSheetService.showCustomBottomSheet(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => FilterBottomView(
        homeViewModel: this,
      ),
    );
  }

  void like(String listingId, bool like) {
    _productService.like(listingId, like);
  }

  void isLiked(String listingId) {
    if (_productService.favList.contains(listingId)) {
      print("Yes");
    }
  }

  Future<void> fetchFavList() async {
    favList = await _productService.getFavList();
    notifyListeners();
  }
}
