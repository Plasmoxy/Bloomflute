import 'package:flutter/material.dart';

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.teal,
    accentColor: Colors.deepPurpleAccent,
  );
}

ThemeData lightTheme() {
  return ThemeData(
    primarySwatch: Colors.teal,
    accentColor: Colors.deepPurpleAccent,
  );
}
