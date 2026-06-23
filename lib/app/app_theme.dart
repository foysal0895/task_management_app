import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),
      ),
      inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[200],
      hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
      labelStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),

      // Default border state
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),

      // Border when the user clicks into the text field
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.blue, width: 2.0),
      ),

      // Border when there is a validation error
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.red, width: 1.0),
      ),
    ),


    );
  }
  static ThemeData get darkTheme{
    return ThemeData(
      brightness: Brightness.dark,

    );
  }

  ThemeData get textTheme{
    return ThemeData(
      useMaterial3: true,
    );
  }
  }
