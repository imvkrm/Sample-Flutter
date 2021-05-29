import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.removeTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function removeTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor=Colors.orange;

  @override
  void initState() {
    const avaliableColor = [
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.pink,
      Colors.yellow
    ];
    _bgColor = avaliableColor[Random().nextInt(5)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: CircleAvatar(
        backgroundColor: _bgColor,
        radius: 32,
        child: Padding(
          padding: EdgeInsets.all(4),
          child: FittedBox(
            child: Text(
              '₹${widget.transaction.amount.toStringAsFixed(0)}',
            ),
          ),
        ),
      ),
      title: Text(
        widget.transaction.title,
      ),
      subtitle: Text(
        DateFormat.yMMMd().format(widget.transaction.date),
      ),
      trailing: MediaQuery.of(context).size.width < 420
          ? IconButton(
              icon: Icon(Icons.cancel_rounded),
              color: Theme.of(context).errorColor,
              onPressed: () {
                widget.removeTransaction(widget.transaction.id);
              },
            )
          : TextButton.icon(
              onPressed: () {
                widget.removeTransaction(widget.transaction.id);
              },
              icon: const Icon(Icons.cancel_rounded),
              label: const Text('Delete'),
              style: TextButton.styleFrom(
                textStyle: TextStyle(color: Theme.of(context).errorColor),
                primary: Theme.of(context).errorColor,
              ),
            ),
    )

        // Row(
        //   children: [
        //     Container(
        //       margin: EdgeInsets.all(10),
        //       padding: EdgeInsets.all(8),
        //       decoration: BoxDecoration(
        //         border: Border.all(
        //           color: Theme.of(context).primaryColorLight,
        //           width: 1,
        //         ),
        //       ),
        //       child: Text(
        //         '₹${transactions[index].amount.toStringAsFixed(2)}',
        //         style: AppBarTheme.of(context).textTheme?.headline6,
        //         // style: TextStyle(
        //         //     fontWeight: FontWeight.bold,
        //         //     fontSize: 16,
        //         //     color: Theme.of(context).primaryColor),
        //       ),
        //     ),
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(
        //           transactions[index].title,
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 14,
        //           ),
        //         ),
        //         Text(
        //           DateFormat.yMMMd().format(transactions[index].date),
        //           style: TextStyle(fontSize: 12, color: Colors.grey),
        //         )
        //       ],
        //     )
        //   ],
        // ),
        );
  }
}
