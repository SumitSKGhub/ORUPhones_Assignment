import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oruphones/ui/views/home/home_viewmodel.dart';
import 'package:oruphones/ui/widgets/brand_icon.dart';
import 'package:oruphones/ui/widgets/carousel_view.dart';
import 'package:oruphones/ui/widgets/chip.dart';
import 'package:oruphones/ui/widgets/circle_icon.dart';
import 'package:oruphones/ui/widgets/product_card.dart';
import 'package:oruphones/ui/widgets/whats_on_mind.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  int adindex = 0;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (model) => model.fetchProducts(), //on loading the model
      builder: (context, model, child) =>
      model.isFetching
          ? Container(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()),
            )
          : Scaffold(
              drawer: Drawer(
                width: MediaQuery.of(context).size.width * 0.7,
                elevation: 2,
                child: Column(
                  children: [
                    DrawerHeader(
                        child: Center(
                      child: Text("Menu"),
                    )),
                    Expanded(
                      child: ListView.builder(
                          itemCount: model.favList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(model.favList[index]),
                            );
                          }),
                    )
                  ],
                ),
              ),
              appBar: AppBar(
                leading: IconButton(
                  icon: Container(
                      padding: EdgeInsets.all(8),
                      width: 60,
                      height: 60,
                      child: Image.asset(
                        "assets/images/logo/drawer.png",
                        fit: BoxFit.cover,
                      )),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    Container(
                      height: 35,
                      width: 60,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/logo/oru.png",
                            fit: BoxFit.contain,
                          ),
                          Image.asset(
                            "assets/images/logo/PHONES.png",
                            fit: BoxFit.scaleDown,
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Text(
                      "India ",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.location_on_outlined,
                      size: 28,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    !model.isLoggedIn
                        ? Icon(Icons.notifications)
                        : TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            style: ButtonStyle(
                              minimumSize: WidgetStatePropertyAll(Size(70, 40)),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              backgroundColor:
                                  WidgetStateProperty.all(Color(0xFFF6C018)),
                            ),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            )),
                  ],
                ),
              ),
              backgroundColor: Colors.white,
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {},
                label: Row(
                  children: [
                    Text(
                      "Sell",
                      style: TextStyle(
                          color: Color(0xFFF6C018),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.add,
                      color: Color(0xFFF6C018),
                    ),
                  ],
                ),
                backgroundColor: Color(0xFF363636),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Color(0xFFF6C018), width: 4),
                ),
                elevation: 4,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: model.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        model.fetchProducts();
                      },
                      child: SingleChildScrollView(
                        controller: model.scrollController,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText:
                                          "Search phones with make, model...",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Color(0xFFF6C018),
                                      ),
                                      suffixIcon: Icon(Icons.mic_none_outlined),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        // borderSide: BorderSide.none
                                      )),
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    SuggestionChip(label: "Sell Used Phones"),
                                    SuggestionChip(label: "Buy Used Phones"),
                                    SuggestionChip(label: "Compare Prices"),
                                    SuggestionChip(label: "My Profile"),
                                    SuggestionChip(label: "My Listings"),
                                    SuggestionChip(label: "Services"),
                                    SuggestionChip(
                                        label: "Register your Store"),
                                    SuggestionChip(label: "Get the App"),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: CarouselViewScreen(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                  "What's on your mind?",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Color(0xFF525252),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              WhatsOnMind(),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Top brands",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Color(0xFF525252),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    InkWell(
                                        onTap: () {},
                                        child: Icon(
                                            Icons.arrow_forward_ios_outlined))
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    BrandIcon(
                                      imgFile:
                                          "assets/images/large_icons/brands/apple.png",
                                    ),
                                    BrandIcon(
                                      imgFile:
                                          "assets/images/large_icons/brands/mi.png",
                                    ),
                                    BrandIcon(
                                      imgFile:
                                          "assets/images/large_icons/brands/samsung.png",
                                    ),
                                    BrandIcon(
                                      imgFile:
                                          "assets/images/large_icons/brands/vivo.png",
                                    ),
                                    BrandIcon(
                                      imgFile:
                                          "assets/images/large_icons/brands/realme.png",
                                    ),
                                    BrandIcon(
                                      imgFile:
                                          "assets/images/large_icons/brands/moto.png",
                                    ),
                                    BrandIcon(
                                      imgFile:
                                          "assets/images/large_icons/brands/oppo.png",
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFF2F2F2),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "View All ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    color: Color(0xFF3F3E8F)),
                                              ),
                                              Icon(
                                                Icons.arrow_forward,
                                                size: 15,
                                                color: Color(0xFF3F3E8F),
                                              )
                                            ],
                                          )),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Best deals",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Color(0xFF525252),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      " in India",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Color(0xFF3F3E8F),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 13.0),
                                      child: GestureDetector(
                                        onTap: () =>
                                            model.showSortBottomSheet(context),
                                        child: Container(
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: Color(0xFFD7D7D7))),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                "assets/images/icons/sort_icon.png",
                                                scale: 3,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Sort",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Icon(Icons
                                                  .keyboard_arrow_down_sharp)
                                            ],
                                          ),
                                        ),
                                      )),
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(right: 18.0),
                                      child: GestureDetector(
                                        onTap: () => model
                                            .showFilterBottomSheet(context),
                                        child: Container(
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: Color(0xFFD7D7D7))),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                "assets/images/icons/filter_icon.png",
                                                scale: 3,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Filter",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Icon(Icons
                                                  .keyboard_arrow_down_sharp)
                                            ],
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                              model.isFetching
                                  ? Center(child: CircularProgressIndicator())
                                  : GridView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.all(10),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 0.568,
                                      ),
                                      itemCount: model.products.length +
                                          (model.isFetching ? 2 : 0),
                                      itemBuilder: (context, index) {
                                        if (index < model.products.length) {
                                          if ((index + 1) % 7 == 0) {
                                            String adAsset = model.ads[adindex];
                                            adindex = (adindex + 1) %
                                                model.ads.length;
                                            return Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              elevation: 4,
                                              color: Colors.white,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              12)),
                                                  child: Image.asset(
                                                    adAsset,
                                                    fit: BoxFit.cover,
                                                  )),
                                            );
                                          } else {
                                            return ProductCard(
                                                homeViewModel: model,
                                                product: model.products[index],
                                              hcontext: context,
                                            );
                                          }
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                    ),
                            ]),
                      ),
                    ),
            ),
    );
  }
}
