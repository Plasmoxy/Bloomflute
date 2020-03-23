import 'dart:math';

import 'package:flutter/material.dart';
import 'model/transaction.dart';
import 'package:intl/intl.dart';

// key = flutter diffs by Widget type by default, if we want
// to diff by something else (like an id), we have to
// use keys
class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color avatarColor;

  // note: NO SETSTATE INSIDE INITSTATE !
  @override
  void initState() {
    super.initState();
    const kolores = [Colors.red, Colors.black, Colors.blue, Colors.purple];
    avatarColor = kolores[Random().nextInt(kolores.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 8,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: avatarColor,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text('${widget.transaction.amount} €'),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat("dd. MM. yyyy").format(widget.transaction.date),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => widget.deleteTransaction(widget.transaction.id),
        ),
      ),
    );
  }
}
