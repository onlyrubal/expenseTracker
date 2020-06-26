import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

// Getter for getting the grouped weekly transaction information.
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalDayAmountSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalDayAmountSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': totalDayAmountSum,
      };
    }).reversed.toList();
  }

  double get totalWeeklySpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                (totalWeeklySpending == 0
                    ? 0
                    : (data['amount'] as double) / totalWeeklySpending),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
