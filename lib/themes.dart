import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
    // Example background color

    // Define the app bar theme
    appBarTheme: const AppBarTheme(
      color: Color.fromARGB(0, 179, 57, 57),
      elevation: 0,
    ),

    // Define the button theme
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),

    // Define the card theme
    cardTheme: CardTheme(
      color: const Color.fromARGB(255, 206, 180, 255),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),

    // Define the text theme
    textTheme: const TextTheme(
      // ignore: deprecated_member_use
      headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      // ignore: deprecated_member_use
      bodyText2: TextStyle(fontSize: 16.0),
    ));
