import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrandIcon extends StatelessWidget {
  final String imgFile;

  const BrandIcon({super.key, required this.imgFile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: InkWell(
        onTap: (){},
        child: Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
              color: Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(50)),
          child: Image.asset(imgFile,scale: 4.25,),
        ),
      ),
    );
  }
}
