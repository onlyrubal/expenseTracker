import 'dart:io';

import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
          primaryColor: Colors.black,
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: 28.0,
              color: Color(0xff303030),
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
            bodyText2: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //All user transactions -> _userTransactions
  final List<Transaction> _userTransactions = [
    Transaction(id: 't1', title: 'Shoes', amount: 149.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Computer', amount: 949.99, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'Monitor', amount: 249.99, date: DateTime.now()),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

// To show Modal Bottom Sheet
  void _addNewExpense(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      builder: (_) {
        return SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: NewTransaction(_addNewTransaction),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandscape = mediaQuery.orientation == Orientation.landscape;

    // App Bar variable
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Expense Tracker'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _addNewExpense(context),
                  child: Icon(CupertinoIcons.add),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Expense Tracker'),
            backgroundColor: Color(0xff303030),
          );

    final transactionListsWidget = SizedBox(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          (_isLandscape ? 0.9 : 0.7),
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    // Body variable of the main widget .
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          //By default mainAxis is start
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Switch.adaptive(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  )
                ],
              ),
            if (!_isLandscape)
              SizedBox(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            if (!_isLandscape) transactionListsWidget,
            if (_isLandscape)
              _showChart
                  ? SizedBox(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTransactions),
                    )
                  : transactionListsWidget,
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            backgroundColor: Colors.black,
            navigationBar: appBar,
          )
        : Scaffold(
            backgroundColor: Colors.black,
            appBar: appBar,
            body: pageBody,
            floatingActionButton: FloatingActionButton.extended(
              icon: const Icon(Icons.add),
              onPressed: () => _addNewExpense(context),
              label: const Text('Add Expense'),
              backgroundColor: Color(0xff303030),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
