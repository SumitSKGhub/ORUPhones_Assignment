
import 'package:flutter/material.dart';
import 'package:oruphones/ui/widgets/circle_icon.dart';
import 'package:oruphones/ui/widgets/womModel.dart';
import 'package:stacked/stacked.dart';

class WhatsOnMind extends StatelessWidget {
  const WhatsOnMind({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WOMViewModel>.reactive(
      viewModelBuilder: () => WOMViewModel(),
      builder: (context, model, child) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CircularIcon(
                imgPath: "assets/images/large_icons/cart.png",
                title: "Buy Used Phones"),
            CircularIcon(
                imgPath: "assets/images/large_icons/tag.png",
                title: "Sell Used Phones"),
            CircularIcon(
                imgPath:
                "assets/images/large_icons/double_tag.png",
                title: "Compare Prices"),
            CircularIcon(
                imgPath:
                "assets/images/large_icons/profile.png",
                title: "My Profile"),
            CircularIcon(
                imgPath:
                "assets/images/large_icons/listing.png",
                title: "My Listings"),
            CircularIcon(
                imgPath:
                "assets/images/large_icons/open store.png",
                title: "Open Store"),
            CircularIcon(
                imgPath:
                "assets/images/large_icons/services.png",
                title: "Services"),
            CircularIcon(
                imgPath:
                "assets/images/large_icons/health.png",
                title: "Device Health Check"),
            CircularIcon(
                imgPath:
                "assets/images/large_icons/battery.png",
                title: "Battery Health Check"),
            CircularIcon(
                imgPath: "assets/images/large_icons/sim.png",
                title: "IMEI Verification"),
            CircularIcon(
                imgPath:
                "assets/images/large_icons/phone_details.png",
                title: "Device Details"),
            CircularIcon(
                imgPath:
                "assets/images/large_icons/data_wipe.png",
                title: "Data Wipe"),
            CircularIcon(
                imgPath:
                "assets/images/large_icons/warranty.png",
                title: "Under Warranty Phones"),
            CircularIcon(
                imgPath:
                "assets/images/large_icons/premium.png",
                title: "Premium Phones"),
            CircularIcon(
                imgPath:
                "assets/images/large_icons/like new.png",
                title: "Like New Phones"),
            CircularIcon(
                imgPath:
                "assets/images/large_icons/refurbished.png",
                title: "Refurbished Phones"),
            CircularIcon(
                imgPath:
                "assets/images/large_icons/verified.png",
                title: "Verified Phones"),
            CircularIcon(
                imgPath:
                "assets/images/large_icons/negotiation.png",
                title: "My Negotiations"),
            CircularIcon(
                imgPath:
                "assets/images/large_icons/favourites.png",
                title: "My Favourites"),
          ],
        ),
      )
    );


  }
}
