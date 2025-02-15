import 'package:flutter/material.dart';
import 'package:oruphones/ui/views/drawer/drawer_viewmodel.dart';
import 'package:oruphones/ui/widgets/drawer_chip.dart';
import 'package:stacked/stacked.dart';

class CustomDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DrawerViewModel>.reactive(
        viewModelBuilder: () => DrawerViewModel(),
        onViewModelReady: (model) => model.initialize(),
        builder: (context, model, child) => Drawer(
              key: model.scaffoldKey,
              backgroundColor: Colors.white,
              child: model.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        // Close Button and Logo
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 40),
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      "assets/images/logo/oru_logo.png",
                                      fit: BoxFit.scaleDown,
                                      height: 20,
                                      width: 50,
                                      // scale: 5,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                                model.isLoggedIn
                                    ? ListTile(
                                        leading: CircleAvatar(),
                                        title: Text(model.user?.userName ?? "",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                        subtitle: Text("Joined: ${model.user?.createdDate}",style: TextStyle(color: Colors.grey),),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        // Login / Signup Button
                        !model.isLoggedIn
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color(0xFF3E468F), // Adjust color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    minimumSize: Size(double.infinity, 50),
                                  ),
                                  child: Text("Login/SignUp",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              )
                            : SizedBox(),

                        SizedBox(height: 10),

                        // Sell Your Phone Button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color(0xFFF6C018), // Adjust color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              minimumSize: Size(double.infinity, 50),
                            ),
                            child: Text("Sell Your Phone",
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                        model.isLoggedIn
                            ? GestureDetector(
                          onTap: (){
                            model.logout();
                          },
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: ListTile(
                                    leading: Image.asset("assets/images/icons/logout.png",fit: BoxFit.scaleDown,scale: 3,),
                                    title: Text("Logout"),
                                  ),
                              ),
                            )
                            : SizedBox(),

                        Spacer(),

                        // Bottom Navigation Grid
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20, left: 10, right: 10),
                          child: GridView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 1.2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 15),
                            children: [
                              DrawerChip(
                                title: "How to Buy",
                                img: "assets/images/chips/buy.png",
                              ),
                              DrawerChip(
                                title: "How to Sell",
                                img: "assets/images/chips/save.png",
                              ),
                              DrawerChip(
                                title: "Oru Guide",
                                img: "assets/images/chips/book.png",
                              ),
                              DrawerChip(
                                title: "About Us",
                                img: "assets/images/chips/info.png",
                              ),
                              DrawerChip(
                                title: "Privacy Policy",
                                img: "assets/images/chips/doc.png",
                              ),
                              DrawerChip(
                                title: "FAQs",
                                img: "assets/images/chips/FAQ.png",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ));
  }
}
