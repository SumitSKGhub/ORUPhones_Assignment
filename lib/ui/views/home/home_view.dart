import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oruphones/ui/views/drawer/drawer_view.dart';
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
          // model.isFetching
          //     ? Container(
          //         color: Colors.white,
          //         child: Center(child: CircularProgressIndicator()),
          //       )
          //     :
          PopScope(
        canPop: false,
        child: Scaffold(
            key: model.scaffoldKey,
            drawer: CustomDrawer(),
            backgroundColor: Colors.white,
            floatingActionButton:
            model.isFabVisible
            ?
            FloatingActionButton.extended(
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
            )
            : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    expandedHeight: 200,
                    floating: true,
                    pinned: true,
                    leading: SizedBox(),
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Container(
                                      padding: EdgeInsets.all(8),
                                      width: 42,
                                      height: 42,
                                      child: Image.asset(
                                        "assets/images/logo/drawer.png",
                                        fit: BoxFit.cover,

                                      )),
                                  onPressed: () =>
                                      model.scaffoldKey.currentState?.openDrawer(),
                                ),
                                Container(
                                  height: 35,
                                  width: 60,
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/logo/oru_logo.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "India ",
                                  style: TextStyle(
                                      fontSize: 19, fontWeight: FontWeight.w500),
                                ),
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 28,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                model.isLoggedIn
                                    ? Icon(Icons.notifications)
                                    : TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/login');
                                    },
                                    style: ButtonStyle(
                                      minimumSize:
                                      WidgetStatePropertyAll(Size(70, 40)),
                                      shape: WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(8))),
                                      backgroundColor:
                                      WidgetStateProperty.all(Color(0xFFF6C018)),
                                    ),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )),
                                SizedBox(width: 15,)
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                    bottom: PreferredSize(
                        preferredSize: Size.fromHeight(148),
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: "Search phones with make, model...",
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
                                    SuggestionChip(label: "Register your Store"),
                                    SuggestionChip(label: "Get the App"),
                                  ],
                                ),
                              ),
                              SizedBox(height: 11,)
                            ],
                          ),
                        )
                    ),
              
                  ),
                  SliverToBoxAdapter(
                    child: model.isLoading
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
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                                        child:
                                        Icon(Icons.arrow_forward_ios_outlined))
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
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Icon(Icons.keyboard_arrow_down_sharp)
                                            ],
                                          ),
                                        ),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(right: 18.0),
                                      child: GestureDetector(
                                        onTap: () =>
                                            model.showFilterBottomSheet(context),
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
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Icon(Icons.keyboard_arrow_down_sharp)
                                            ],
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                              // model.isFetching
                              //     ? Center(child: CircularProgressIndicator())
                              //     :
                              GridView.builder(
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
                                      adindex = (adindex + 1) % model.ads.length;
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(12)),
                                        elevation: 4,
                                        color: Colors.white,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(12)),
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
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  children: [
                                    Text("Frequently Asked Questions"),
                                    Spacer(),
                                    Icon(Icons.arrow_forward_ios_rounded)
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      // scrollDirection: Axis.vertical,
                                      itemCount: model.faqs.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(18)),
                                          elevation: 1,
                                          child: ExpansionTile(
                                            backgroundColor: Colors.white,
                                            collapsedBackgroundColor: Colors.white,
                                            trailing: Icon(Icons.add),
                                            title: Text(
                                              model.faqs[index].question,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            children: [
                                              Container(
                                                color: Color(0xFFC8C8C8),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16, vertical: 8),
                                                  child: Text(
                                                    model.faqs[index].answer,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey[700],
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ),
                              Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                color: Color(0xFFF6C018),
                                child: Padding(
                                  padding: const EdgeInsets.all(35.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Get Notified About Our Latest Offers and Price Drops",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 22),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(29)),
                                            contentPadding: EdgeInsets.all(12),
                                            hintText: 'Enter your email here',
                                            suffixIcon: ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 6), // Reduced padding
                                                minimumSize: Size(30,
                                                    15), // Sets a smaller width and height
                                                textStyle: TextStyle(
                                                    fontSize:
                                                    14), // Smaller font size
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(
                                                      6), // Slightly rounded corners
                                                ),
                                              ),
                                              child: Text("Send"),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                height: 1100,
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: 659,
                                      width: MediaQuery.of(context).size.width,
                                      color: Color(0xFF363636),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 50,
                                          ),
                                          Text(
                                            "Download App",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 27,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          SizedBox(
                                            height: 50,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Column(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/QR.png',
                                                    fit: BoxFit.scaleDown,
                                                    height: 150,
                                                    width: 150,
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Image.asset(
                                                    'assets/images/logo/Play.png',
                                                    fit: BoxFit.scaleDown,
                                                    height: 50,
                                                    width: 50,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                width: 18,
                                              ),
                                              Column(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/QR.png',
                                                    fit: BoxFit.scaleDown,
                                                    height: 150,
                                                    width: 150,
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Image.asset(
                                                    'assets/images/logo/istore.png',
                                                    fit: BoxFit.scaleDown,
                                                    height: 50,
                                                    width: 50,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 75,
                                          ),
                                          Text(
                                            "Invite a Friend",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 27),
                                          ),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          SizedBox(height: 5,),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 1,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 300,
                                            width: 350,
                                            child: Image.asset(
                                              'assets/images/footer deal.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Text("Or Share",style: TextStyle(color: Colors.black,fontSize: 12),),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Row(
                                              spacing: 20,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Image.asset(
                                                  'assets/images/logo/instagram.png',
                                                  fit: BoxFit.scaleDown,
                                                  height: 50,
                                                  width: 50,
                                                ),
                                                Image.asset(
                                                  'assets/images/logo/telegram.png',
                                                  fit: BoxFit.scaleDown,
                                                  height: 50,
                                                  width: 50,
                                                ),
                                                Image.asset(
                                                  'assets/images/logo/X.png',
                                                  fit: BoxFit.scaleDown,
                                                  height: 50,
                                                  width: 50,
                                                ),
                                                Image.asset(
                                                  'assets/images/logo/whatsapp.png',
                                                  fit: BoxFit.scaleDown,
                                                  height: 50,
                                                  width: 50,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
              
                            ]),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

Widget homeWidget() => SliverToBoxAdapter(
      child:
      ListView.builder(
        primary: false,
          shrinkWrap: true,
          itemCount: 50,
          itemBuilder: (context, index) {
            return Text("data");
          }),
    );
