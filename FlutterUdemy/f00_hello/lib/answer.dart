import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function select;
  final String text;
  Answer(this.select, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        child: Text(text),
        onPressed: select,
        color: Colors.blue,
        textColor: Colors.white,
      ),
    );
  }
}
