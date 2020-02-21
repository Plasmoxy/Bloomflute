import 'package:f00_hello/question.dart';
import 'package:flutter/material.dart';
import 'package:f00_hello/answer.dart';

void main() => runApp(HelloApp());

class HelloApp extends StatefulWidget {
  @override
  createState() => _HelloAppState();
}

class _HelloAppState extends State<HelloApp> {
  var questions = ["Oblubeny chleb ?", "Oblubeny patkaň ?", "Fajne jedlo?"];
  var questionIdx = 0;

  void questionPressed() {
    setState(() {
      if (questionIdx < questions.length - 1) questionIdx++;
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
            Question(questions[questionIdx]),
            Answer(questionPressed),
            Answer(questionPressed),
            Answer(questionPressed)
          ],
        ),
      ),
    );
  }
}
