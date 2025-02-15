import 'package:flutter/material.dart';

class StretchedButton extends StatelessWidget {
  final String text;
  final bool icon;
  final String route;
  final String info;

  const StretchedButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.route,
      required this.info
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 62,
      child: TextButton(
        style: TextButton.styleFrom(
          // fixedSize:WidgetStateProperty.all<Size?>(Size(500.0, 70.0)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          backgroundColor: Color(0xFF3F3E8F),
        ),
        onPressed: () {
          if(info!=''){
            Navigator.pushNamed(context, '/$route');
          }
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
