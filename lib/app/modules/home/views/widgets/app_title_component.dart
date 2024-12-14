import 'package:flutter/material.dart';

class AppTitleComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center( // Centers the title widget horizontally
      child: Text(
        'Helping Hand', // Replace with your actual app title
        style: TextStyle(
          fontSize: 32, // Adjust the size as needed
          fontFamily: 'Fredoka One', // Use sth similar with SuckerPunch BB Regular
          color: Color(0xFFB39DDB), // Pastel purple color
          fontWeight: FontWeight.bold, // Use normal weight for this font
        ),
      ),
    );
  }
}
