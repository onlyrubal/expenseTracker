import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage(
        'assets/images/waiting.png'); //<- Creates an object that fetches an image.
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    Text(
                      'No Expenses added yet...',
                      // style: TextStyle(
                      //   color: Color(0xff4c4c4c),
                      //   fontSize: 24,
                      //   fontStyle: FontStyle.italic,
                      //   fontWeight: FontWeight.w500,
                      // ),

                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: new Image(
                        image: assetsImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemCount: transactions.length,
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
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            DateFormat.yMMMd().format(transactions[index].date),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 20, bottom: 2),
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
                              width: 100,
                              height: 20,
                              child: FittedBox(
                                child: Text(
                                  'CAD ' +
                                      transactions[index]
                                          .amount
                                          .toStringAsFixed(2),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xafffffff),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: MediaQuery.of(context).size.width > 360
                              ? FlatButton.icon(
                                  onPressed: () =>
                                      deleteTransaction(transactions[index].id),
                                  icon: Icon(Icons.delete_outline),
                                  textColor: Colors.red,
                                  label: Text('Delete'),
                                )
                              : IconButton(
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: Colors.red,
                                    size: 25,
                                  ),
                                  onPressed: () =>
                                      deleteTransaction(transactions[index].id),
                                ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
