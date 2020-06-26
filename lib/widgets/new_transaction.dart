import 'dart:io';

import '../widgets/adaptive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;
  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) return;
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;
    widget.addNewTransaction(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then(
      (datePicked) {
        if (datePicked == null) return;

        setState(() {
          _selectedDate = datePicked;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: double.infinity,
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(20, 40, 20, 40),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff4c4c4c),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff4c4c4c),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  labelText: 'Expense Title',
                ),
                onSubmitted: (_) => _submitData(),
                controller: _titleController,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff4c4c4c),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff4c4c4c),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                onSubmitted: (_) => _submitData(),
                controller: _amountController,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      (_selectedDate == null)
                          ? 'No Date Chosen!'
                          : 'Date Picked: ${DateFormat.yMMMd().format(_selectedDate)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: AdaptiveButton(
                        buttonText: 'Choose Date',
                        datePickerHandler: _showDatePicker),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Platform.isIOS
                  ? CupertinoButton(
                      onPressed: _submitData,
                      child: Text(
                        'Add Transaction',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(4),
                      padding: EdgeInsets.all(0),
                    )
                  : RaisedButton(
                      elevation: 2,
                      onPressed: _submitData,
                      child: Text('Add Transaction'),
                      textColor: Color(0xffffffff),
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xff4c4c4c),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
