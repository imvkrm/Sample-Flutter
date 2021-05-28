import 'package:flutter/material.dart';
import './new_transaction.dart';
import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> transactions = [
    Transaction(
        id: 't1', title: 'Nike Shoes', amount: 7999, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Weekly Groceries', amount: 565, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'Fuel Charges', amount: 399, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'New Pants', amount: 3999, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'Cooler Repairs', amount: 250, date: DateTime.now()),
    Transaction(id: 't3', title: 'Others', amount: 1200, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'New Watch', amount: 8999, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'New Phone', amount: 18999, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'New Ear Buds', amount: 4999, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'Fast Food', amount: 399, date: DateTime.now()),
  ];

  void _addNewTransaction(String newTitle, double newAmount) {
    var _newTx = Transaction(
        id: DateTime.now().toString(),
        title: newTitle,
        amount: newAmount,
        date: DateTime.now());

    setState(() {
      transactions.add(_newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
       // TransactionList(transactions)
      ],
    );
  }
}
