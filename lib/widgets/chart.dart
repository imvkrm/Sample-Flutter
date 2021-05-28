import '../models/transaction.dart';
import '../widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionsValue.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: EdgeInsets.all(8),
              child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValue.map((rtx) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  rtx['day'].toString(),
                  rtx['amount'] as double,
                  totalSpending == 0.0
                      ? 0.0
                      : (rtx['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
