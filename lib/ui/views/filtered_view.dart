//
// import 'package:flutter/material.dart';
// import 'package:oruphones/ui/views/filtered_viewmodel.dart';
// import 'package:oruphones/ui/widgets/product_card.dart';
// import 'package:stacked/stacked.dart';
//
// class FilteredView extends StatelessWidget {
//   int adindex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<FilteredViewModel>.reactive(
//       viewModelBuilder: () => FilteredViewModel(),
//       builder: (context, model, child)=> Scaffold(
//         // appBar: AppBar(),
//         body: SafeArea(  // safe area to place widgets
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: Row(
//                     children: [
//                       Text(
//                         "Best deals",
//                         style: TextStyle(
//                             fontSize: 22,
//                             color: Color(0xFF525252),
//                             fontWeight: FontWeight.w500),
//                       ),
//                       Text(
//                         " in India",
//                         style: TextStyle(
//                             fontSize: 22,
//                             color: Color(0xFF3F3E8F),
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 13.0),
//                         child:
//                         GestureDetector(
//                           // onTap: () => model.showSortBottomSheet(context),
//                           child: Container(
//                             padding: EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 border: Border.all(color: Color(0xFFD7D7D7))
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Image.asset("assets/images/icons/sort_icon.png",scale: 3,),
//                                 SizedBox(width: 10,),
//                                 Text("Sort",style: TextStyle(fontWeight: FontWeight.bold),),
//                                 SizedBox(width: 6,),
//                                 Icon(Icons.keyboard_arrow_down_sharp)
//                               ],
//                             ),
//                           ),
//                         )
//                     ),
//                     Padding(
//                         padding: const EdgeInsets.only(right: 18.0),
//                         child:
//                         GestureDetector(
//                           onTap: () => model.showFilterBottomSheet(context),
//                           child: Container(
//                             padding: EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 border: Border.all(color: Color(0xFFD7D7D7))
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Image.asset("assets/images/icons/filter_icon.png",scale: 3,),
//                                 SizedBox(width: 10,),
//                                 Text("Filter",style: TextStyle(fontWeight: FontWeight.bold),),
//                                 SizedBox(width: 6,),
//                                 Icon(Icons.keyboard_arrow_down_sharp)
//                               ],
//                             ),
//                           ),
//                         )
//                     ),
//                   ],
//                 ),
//                 // model.isFetching
//                 // ? CircularProgressIndicator()
//                 // :
//                 GridView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   padding: EdgeInsets.all(10),
//                   gridDelegate:
//                   SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                     childAspectRatio: 0.568,
//                   ),
//                   itemCount: model.products.length +
//                       (model.isFetching ? 2 : 0),
//                   itemBuilder: (context, index) {
//                     if (index < model.products.length) {
//                       if ((index + 1) % 7 == 0) {
//                         String adAsset = model.ads[adindex];
//                         adindex = (adindex + 1) % model.ads.length;
//                         return Card(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12)),
//                           elevation: 4,
//                           color: Colors.white,
//                           child: ClipRRect(
//                               borderRadius: BorderRadius.vertical(
//                                   top: Radius.circular(12)),
//                               child: Image.asset(
//                                 adAsset,
//                                 fit: BoxFit.cover,
//                               )
//                           ),
//                         );
//                       } else {
//                         return ProductCard(
//                             product: model.products[index]);
//                       }
//                     } else {
//                       return Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
