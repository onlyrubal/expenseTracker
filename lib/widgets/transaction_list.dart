import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 580,
      margin: EdgeInsets.only(bottom: 20),
      child: ListView.builder(
        itemBuilder: (buildContext, index) {
          return Card(
            elevation: 0.0,
            color: Colors.transparent,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff4c4c4c),
              ),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.green,
                      size: 30.0,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          transactions[index].title,
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 1),
                        child: Text(
                          'CAD ' +
                              transactions[index].amount.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xafffffff),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ))
                ],
              ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
