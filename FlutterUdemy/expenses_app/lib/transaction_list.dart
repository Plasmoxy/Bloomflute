import 'package:expenses_app/model/transaction.dart';
import 'package:flutter/material.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: constraints.maxHeight * 0.4,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, idx) => TransactionItem(
              // pass a new unique key to determine that each item is unique
              key: ValueKey(transactions[idx].id),
              transaction: transactions[idx],
              deleteTransaction: deleteTransaction,
            ),
            itemCount: transactions.length,
          );
  }
}

/*
CARD TYCH ITEMOV ALT ku ListTile

Card(
  elevation: 3,
  child: Row(
    children: <Widget>[
      // price
      Container(
        margin: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Theme.of(context).primaryColor,
            ),
            borderRadius:
                BorderRadius.all(Radius.circular(10))),
        child: Text(
          '${tx.amount.toStringAsFixed(2)} €',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      // title and date
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            tx.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            DateFormat('dd. MM. yyyy').format(tx.date),
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ],
  ),
);
*/
