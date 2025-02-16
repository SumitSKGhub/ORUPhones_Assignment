import 'package:oruphones/core/services/bottom_sheet_service.dart';
import 'package:oruphones/core/services/product_service.dart';
import 'package:oruphones/locator.dart';
import 'package:stacked/stacked.dart';

class FilterViewModel extends BaseViewModel {
  final productService = locator<ProductService>();

  // final List<String> categories = [
  //   "Brand",
  //   "Condition",
  //   "Storage",
  //   "Ram",
  //   "Verification",
  //   "Warranty",
  //   // "Location",
  //   // "Distance",
  //   "Price Range"
  // ];
  //
  // final Map<String, List<String>> filterOptions = {
  //   "Brand": ["Apple","Samsung","Google","OnePlus","Xiaomi"],
  //   "Condition": ["Like New", "Excellent", "Good", "Fair", "Needs Repair"],
  //   "Storage": ["8 GB","16 GB", "32 GB", "64 GB", "128 GB","256 GB","512 GB","1 TB"],
  //   "Ram": ["2 GB","3 GB", "4 GB","5 GB", "6 GB","7 GB", "8 GB", "12 GB", "16 GB"],
  //   "Verification": ["Verified Only"],
  //   "Warranty": ["Brand Warranty", "Seller Warranty"],
  //   "Price Range": [""]
  //   // "Location": [""],
  //   // "Distance": [""],
  // };

  late final List<String> categories ;
  late final Map<String, List<String>> filterOptions;

  void getFilter(){
    categories = productService.categories;
    filterOptions = productService.filterOptions;
    notifyListeners();
  }

  String selectedCategory = "Condition";
  final Map<String, bool> selectedFilters = {};

  List<String> selected = [];
  List<String> filters = [];

  void setCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  void toggleFilter(String option) {
    // if(selectedFilters.containsKey(option)){
    //   selectedFilters[option] = !selectedFilters[option]!;
    //   if(!selectedFilters[option]!){
    //     selectedFilters.remove(option);
    //   }
    // }else{
    //   selectedFilters[option] = true;
    // }
    selectedFilters[option] = !(selectedFilters[option] ?? false);
    print(selectedFilters);
    notifyListeners();
  }

  void clearFilters() {
    selectedFilters.clear();
    selected.clear();
    filters.clear();
    notifyListeners();
  }

  Future<void> applyFilters(int page, String selectedSort) async{
    // Map<String, List<String>> selectedFilterMap = {};
    Map<String, List<String>> structuredFilters = {};

    selectedFilters.forEach((key,value){
      if(value){
        structuredFilters.putIfAbsent(selectedCategory, () => []).add(key);
      }
    });

    await productService.fetchProducts(page, selectedSort, structuredFilters);

  }

  // void showFilterBottomSheet(){
  //   // bottomSheetService.
  // }
}
