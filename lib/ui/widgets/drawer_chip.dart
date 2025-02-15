

import 'package:flutter/material.dart';

class DrawerChip extends StatelessWidget {
  final String title;
  final String img;
  const DrawerChip({super.key, required this.title, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            img,
            fit: BoxFit.scaleDown,
            scale: 3,
          ),
          Text(title,
            style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
