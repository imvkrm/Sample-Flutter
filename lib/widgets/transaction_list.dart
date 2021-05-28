import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;

  TransactionList(this.transactions, this.removeTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'No transaction added yet',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                    height: 360,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: ListTile(
                  leading: CircleAvatar(
                    radius: 32,
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: FittedBox(
                        child: Text(
                          '₹${transactions[index].amount.toStringAsFixed(0)}',
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.cancel_rounded),
                    color: Theme.of(context).errorColor,
                    onPressed: () {
                      removeTransaction(transactions[index].id);
                    },
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
              },
            ),
    );
  }
}
