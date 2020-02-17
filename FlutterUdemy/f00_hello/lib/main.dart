import 'package:flutter/material.dart';

void main() => runApp(HelloApp());

class HelloApp extends StatefulWidget {
  @override
  createState() => HelloAppState();
}

class HelloAppState extends State<HelloApp> {
  var questions = ["Oblubeny chleb ?", "Oblubeny patkaň ?", "Fajne jedlo?"];
  var questionIdx = 0;

  void questionPressed() {
    setState(() {
      if (questionIdx < questions.length-1) questionIdx++;
    });
  }

  @override
  build(context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello'),
        ),
        body: Column(
          children: <Widget>[
            Text(questions[questionIdx]),
            RaisedButton(
              child: Text('Answer'),
              onPressed: questionPressed,
            ),
            RaisedButton(
              child: Text(''),
              onPressed: questionPressed,
            ),
            RaisedButton(
              child: Text(''),
              onPressed: questionPressed,
            ),
          ],
        ),
      ),
    );
  }
}
