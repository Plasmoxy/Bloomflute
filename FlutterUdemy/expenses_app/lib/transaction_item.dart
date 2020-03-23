import 'dart:math';

import 'package:flutter/material.dart';
import 'model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.tx,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction tx;
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
              child: Text('${widget.tx.amount} €'),
            ),
          ),
        ),
        title: Text(
          widget.tx.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat("dd. MM. yyyy").format(widget.tx.date),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => widget.deleteTransaction(widget.tx.id),
        ),
      ),
    );
  }
}
