import 'package:f00_hello/answer.dart';
import 'package:f00_hello/question.dart';
import 'package:flutter/material.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final Function questionPressed;
  final int questionIdx;

  Quiz(
      {@required this.questionPressed,
      @required this.questions,
      @required this.questionIdx});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Question(questions[questionIdx]['questionText']),
        ...(questions[questionIdx]['answers'] as List<Map<String, Object>>)
            .map((q) => Answer(() => questionPressed(q['score']), q['text']))
            .toList(),
      ],
    );
  }
}
