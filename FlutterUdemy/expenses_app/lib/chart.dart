import 'package:expenses_app/chart_bar.dart';
import 'package:expenses_app/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (idx) {
      final weekDay = DateTime.now().subtract(
        Duration(days: idx),
      );
      double totalSum = 0.0;

      // spocitaj vsetky transactions z daneho dna
      for (var t in recentTransactions) {
        if (t.date.day == weekDay.day &&
            t.date.month == weekDay.month &&
            t.date.year == weekDay.year) {
          totalSum += t.amount;
        }
      }

      // e = shortcut of the weekday
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    });
  }

  double get totalSpending =>
      groupedTransactionValues.fold(0.0, (sum, item) => sum + item['amount']);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((data) {
            final percent = totalSpending != 0.0
                ? (data['amount'] as double) / totalSpending
                : 0.0;
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(data['day'], data['amount'], percent),
            );
          }).toList(),
        ),
      ),
    );
  }
}
