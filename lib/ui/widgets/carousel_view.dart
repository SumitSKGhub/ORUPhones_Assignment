

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:oruphones/ui/widgets/carousel_viewmodel.dart';
import 'package:stacked/stacked.dart';

class CarouselViewScreen extends StatelessWidget {
  const CarouselViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CarouselVieModel>.reactive(
      viewModelBuilder: () => CarouselVieModel(),
      builder: (context, model, child) =>
          Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    height: 180,
                    autoPlay: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason){
                      model.carouselIndex = index;
                      model.notifyListeners();
                    }
                  // enlargeCenterPage: true
                ),
                items: model.images.map((imgPath){
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Container(
                          width: double.infinity,
                          child: Image.asset(
                            imgPath, fit: BoxFit.scaleDown,)
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                  model.images.asMap().entries.map((entry){
                    return Container(
                      width: 8,
                      height: 8,
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        shape: BoxShape.circle,
                        color: model.carouselIndex == entry.key ? Colors.grey : Colors.transparent
                      ),
                    );
                  }).toList(),

              )
            ],
          ),
    );
  }
}
