import 'package:expense_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';

class ChartModel {
  String day;
  double amount;
  ChartModel({required this.day, required this.amount}) {}
}

class Chart extends StatelessWidget {
  Chart({required this.recentTransactions});

  final List<Transaction> recentTransactions;

  List<ChartModel> get groupTransactionValues {
    return List.generate(2, (index) {
      final model = recentTransactions[index];
      final weekday = DateTime.now().subtract(Duration(days: index));
      double sum = 0;
      for (var element in recentTransactions) {
        if (weekday.month == model.date.month &&
            weekday.year == model.date.year &&
            weekday.day == model.date.day) {
          sum += element.amount;
        }
      }
      return ChartModel(
        day: DateFormat.E().format(weekday).substring(0, 1),
        amount: sum,
      );
    });
  }

  double get maxSpendng {
    return groupTransactionValues.fold(0.0, (sum, item) {
      return sum + item.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(
        20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...groupTransactionValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: e.day,
                spendingAmount: e.amount,
                spendingPctOfTotal: maxSpendng == 0 ? 0 : e.amount / maxSpendng,
              ),
            );
          }).toList()
        ],
      ),
    );
  }
}
