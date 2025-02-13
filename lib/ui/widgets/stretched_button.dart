import 'package:flutter/material.dart';

class StretchedButton extends StatelessWidget {
  final String text;
  final bool icon;

  const StretchedButton(
      {super.key,
      required this.text,
      required this.icon,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: TextButton(
        style: TextButton.styleFrom(
          // fixedSize:WidgetStateProperty.all<Size?>(Size(500.0, 70.0)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          backgroundColor: Color(0xFF3F3E8F),
        ),
        onPressed: () {
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 19),
            ),
            icon
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20,
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
    //
    // Row(
    //   children: [
    //     Expanded(
    //       child: TextButton(
    //           style: ButtonStyle(
    //             // fixedSize:WidgetStateProperty.all<Size?>(Size(500.0, 70.0)),
    //             backgroundColor:
    //             WidgetStateProperty.all<Color>(Color(0xFF3F3E8F)),
    //           ),
    //           onPressed: () {},
    //           child: Text(
    //             text,
    //             style: TextStyle(color: Colors.white),
    //           )),
    //     ),
    //   ],
    // );
  }
}
