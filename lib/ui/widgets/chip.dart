
import 'package:flutter/material.dart';

class SuggestionChip extends StatelessWidget {
  final String label;

  const SuggestionChip({super.key,required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.grey),
            ),
          ),
          child: Text(label,style: TextStyle(fontWeight: FontWeight.bold),)),
    );
  }
}
