import 'package:f00_hello/quiz.dart';
import 'package:f00_hello/result.dart';
import 'package:flutter/material.dart';

Map<String, Object> _answer(String text, int score) =>
    {'text': text, 'score': score};

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
      "questionText": "Aky je tvoj oblubeny chleb???",
      'answers': [
        _answer("Parmezan", 10),
        _answer("Herold", 17),
        _answer("Šmerdzaci", 20)
      ]
    },
    {
      "questionText": "Aky je tvoj oblubeny patkaň???",
      'answers': [
        _answer("Jerry", 10),
        _answer("Tom", 11),
        _answer("Myšak zos kanala", 150)
      ]
    },
    {
      "questionText": "Aky je tvoj oblubeny policajt???",
      'answers': [
        _answer("Policajna akademia 4", 12),
        _answer("h", 20),
        _answer("Šesnasť dvanástnikov", 10)
      ]
    }
  ];

  var questionIdx = 0;
  var totalScore = 0;

  void questionPressed(int score) {
    setState(() {
      totalScore += score;
      if (questionIdx < questions.length) questionIdx++;
    });
  }

  @override
  build(context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Zodpovedaj na otazky!!!'),
        ),
        body: (questionIdx < questions.length)
            ? Quiz(
                questions: questions,
                questionPressed: questionPressed,
                questionIdx: questionIdx,
              )
            : Result(totalScore),
      ),
    );
  }
}
