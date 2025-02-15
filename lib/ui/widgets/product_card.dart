import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oruphones/core/models/product_model.dart';
import 'package:oruphones/core/services/auth_service.dart';
import 'package:oruphones/locator.dart';
import 'package:oruphones/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked_annotations.dart';

class ProductCard extends StatelessWidget {
  final HomeViewModel homeViewModel;
  final Product product;
  final BuildContext hcontext;

  ProductCard({super.key, required this.product, required this.homeViewModel,required this.hcontext});

  @override
  Widget build(BuildContext context) {
    final List months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'June',
      'July',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec'
    ];

    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        color: Colors.white,
        // margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Stack(
                  children: [
                    Image.network(
                      product.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    product.verified
                        ? Positioned(
                            top: 10,
                            child: Image.asset(
                                "assets/images/banners/banner_verified.png"))
                        : SizedBox(),
                    product.verified
                        ? Positioned(
                            top: 12.8,
                            left: 7,
                            child: Row(
                              children: [
                                Text(
                                  "ORU",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Verified",
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white),
                                )
                              ],
                            ),
                          )
                        : SizedBox(),
                    Positioned(
                        top: 10,
                        right: 10,
                        child:
                           GestureDetector(
                             onTap: (){
                               homeViewModel.launchOTPBottomSheet(hcontext);
                               print(product.listingId);
                               if(homeViewModel.favList.contains(product.listingId)){
                                 print("Already in favorites");
                               }else{
                               }
                               // homeViewModel.favList.contains(product.listingId);
                               // homeViewModel.like(product.listingId,true);
                             },
                               child: Image.asset("assets/images/icons/like_icon.png")
                           )
                    ),
                    Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: 0.7,
                          child: Container(
                            height: 25,
                            width: MediaQuery.of(context).size.width, //50,
                            color: Colors.grey,
                          ),
                        )),
                    product.negotiate
                        ? Positioned(
                            bottom: 4.5,
                            left: 30,
                            child: Text(
                              "PRICE NEGOTIABLE",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900),
                            ),
                          )
                        : SizedBox(),
                  ],
                )),
            Container(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(product.ram.split(" ")[0]),
                        Text("/" + product.storage),
                        Text(
                          " • ",
                          style: TextStyle(fontSize: 19, color: Colors.grey),
                        ),
                        Text(
                          product.condition,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.2,
                    ),
                    Row(
                      children: [
                        Text(
                          "₹ ${product.price} ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        product.discount != '0'
                            ? Text(
                                // void main() {
                                // String price = "4900";
                                // String discount = "26.864580068359228";
                                // String result = ((int.parse(price)*100)/int.parse((discount.split(".")[0]))).toString();
                                //
                                //
                                // print(result);
                                // }
                                "${((int.parse(product.price) / (100 - int.parse(product.discount.split(".")[0]))) * 100).toString().split(".")[0]}",
                                style: TextStyle(
                                    fontSize: 10,
                                    decoration: TextDecoration.lineThrough),
                              )
                            : Text(""),
                        // Text(" PRICE"),
                        Text(
                            product.discount != '0'
                                ? " (${product.discount.split(".")[0]})%"
                                : "",
                            style: TextStyle(
                              color: Colors.red,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFFD7D7D7),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12))),
                child: Row(
                  children: [
                    SizedBox(
                      width: 85,
                      child: Text(
                        '${product.location}, ${product.locality}',
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${months[DateTime.parse(product.created).month - 1]}, ${DateTime.parse(product.created).day.toString()}',
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            )
          ],
        )
        // ListTile(
        //   leading: Image.network(product.imageUrl,width: 50,height: 50,fit: BoxFit.cover),
        //   title: Text(product.name, style: TextStyle(fontWeight: FontWeight.bold),),
        //   subtitle: Text("₹${product.price}"),
        // ),
        );
  }
}
