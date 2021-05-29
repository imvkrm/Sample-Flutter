import 'dart:io';

import 'package:expense_planner_flutter/widgets/adaptive_flat_button.dart';
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

  var _selectedDate;

  void _submitNewTxt() {
    var _enteredtitle = _titleController.text;
    var _enteredAmount = _amountController.text;

    if (_enteredtitle.isEmpty ||
        _enteredAmount.isEmpty ||
        _selectedDate == null) {
      return;
    }

    widget.addNewTransaction(
        _enteredtitle, double.parse(_enteredAmount), _selectedDate);

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      setState(() {
        _selectedDate = value;
      });

      print(_selectedDate.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 4,
        child: Container(
          padding: EdgeInsets.only(
              top: 8,
              left: 8,
              right: 8,
              bottom: MediaQuery.of(context).viewInsets.bottom + 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Expense Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitNewTxt(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Expense Amount'),
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitNewTxt(),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Selected'
                            : 'Picked Date ${DateFormat.yMMMMd().format(_selectedDate as DateTime)}',
                      ),
                    ),
                   AdaptiveFlatButton(_showDatePicker,'Choose Date')
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitNewTxt,
                child: Text('Add Transaction'),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).textTheme.button?.color),
              )
            ],
          ),
        ),
      ),
    );
  }
}
