import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.deepPurple,
  primaryColor: Colors.deepPurpleAccent,
  accentColor: Colors.deepPurpleAccent,
  appBarTheme: ThemeData.dark().appBarTheme.copyWith(
        color: Colors.black,
      ),
  dialogBackgroundColor: Colors.red,
  cardColor: Color(0xFF111112),
  canvasColor: Colors.black,
  dialogTheme: ThemeData.dark().dialogTheme.copyWith(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
      ),
);

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.teal,
  accentColor: Colors.deepPurpleAccent,
  dialogTheme: ThemeData.dark().dialogTheme.copyWith(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
      ),
);
