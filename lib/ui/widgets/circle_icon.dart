import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularIcon extends StatelessWidget {
  final String imgPath;
  final String title;

  const CircularIcon({super.key, required this.imgPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        // alignment: Alignment.center,
        width: 100,
        height: 150,
        child: Column(
          children: [
            SizedBox(
                height: 100,
                width: 110,
                child: Image.asset(
                  imgPath,
                  scale: 3.8,
                )),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
