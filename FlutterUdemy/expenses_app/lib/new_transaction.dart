import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final void Function(String, double) addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submit() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0) {
      return;
    }

    widget.addTransaction(title, amount);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
            Container(
              height: 70,
              child: Row(children: <Widget>[
                Text('No date chosen!'),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _presentDatePicker,
                ),
              ]),
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: submit,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
