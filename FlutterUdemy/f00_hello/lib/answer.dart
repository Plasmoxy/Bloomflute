import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function select;
  Answer(this.select);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        child: Text('Anwer 1'),
        onPressed: select,
        color: Colors.blue,
      ),
    );
  }
}
