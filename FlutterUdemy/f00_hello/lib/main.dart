import 'package:f00_hello/question.dart';
import 'package:flutter/material.dart';
import 'package:f00_hello/answer.dart';

void main() => runApp(HelloApp());

/* ysoh hello
there */
class HelloApp extends StatefulWidget {
  @override
  createState() => _HelloAppState();
}

class _HelloAppState extends State<HelloApp> {
  final questions = [
    {
      "questionText": "Aky je tvoj oblubeny chleb??",
      'answers': ["Parmezan", "Herold", "Šmerdzaci"]
    },
    {
      "questionText": "Aky je tvoj oblubeny patkaň??",
      'answers': ["Jerry", "Tom", "Myšak zos kanala"]
    },
    {
      "questionText": "Aky je tvoj oblubeny policajt??",
      'answers': ["Policajna akademia 4", "h", "Šesnasť dvanástnikov"]
    }
  ];

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
            Question(questions[questionIdx]['questionText']),
            ...(questions[questionIdx]['answers'] as List<String>)
                .map((q) => Answer(questionPressed, q))
                .toList(),
          ],
        ),
      ),
    );
  }
}
