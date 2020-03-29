import 'package:flutter/material.dart';

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.deepPurple,
    primaryColor: Colors.deepPurpleAccent,
    accentColor: Colors.deepPurpleAccent,
    appBarTheme: ThemeData.dark().appBarTheme.copyWith(
          color: Colors.black26,
        ),
  );
}

ThemeData lightTheme() {
  return ThemeData(
    primarySwatch: Colors.teal,
    accentColor: Colors.deepPurpleAccent,
  );
}
