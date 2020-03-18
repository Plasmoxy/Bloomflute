import 'package:expenses_app/model/transaction.dart';
import 'package:expenses_app/new_transaction.dart';
import 'package:expenses_app/transaction_list.dart';
import 'package:flutter/material.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> transactions = [
    Transaction(
        id: 'shoes', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 'car', title: 'New car', amount: 69.99, date: DateTime.now()),
  ];

  void addTransaction(String title, double amount) {
    final t = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );
    setState(() {
      transactions.add(t);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(addTransaction),
        TransactionList(transactions),
      ],
    );
  }
}
