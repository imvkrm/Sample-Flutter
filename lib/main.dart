import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/chart.dart';
//import 'package:flutter/services.dart';
import '../models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Planner',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amberAccent,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(color: Colors.purpleAccent),
              ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _transactions = [
    Transaction(
        id: 't1',
        title: 'Nike Shoes',
        amount: 7999,
        date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(
        id: 't2',
        title: 'Weekly Groceries',
        amount: 1565,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        id: 't3', title: 'New Pants', amount: 5999, date: DateTime.now()),
    Transaction(
        id: 't4', title: 'Nike Shorts', amount: 799, date: DateTime.now()),
    Transaction(
        id: 't5',
        title: 'Weekly Vegetables',
        amount: 565,
        date: DateTime.now()),
    Transaction(
        id: 't6', title: 'Fuel Charges', amount: 399, date: DateTime.now()),
    Transaction(
        id: 't7', title: 'New Pants', amount: 3999, date: DateTime.now()),
    Transaction(
        id: 't8', title: 'Cooler Repairs', amount: 250, date: DateTime.now()),
    Transaction(id: 't9', title: 'Others', amount: 1200, date: DateTime.now()),
    Transaction(
        id: 't10', title: 'New Watch', amount: 8999, date: DateTime.now()),
  ];

  bool _showChart = false;

  void _addNewTransaction(String newTitle, double newAmount, DateTime date) {
    var _newTx = Transaction(
        id: DateTime.now().toString(),
        title: newTitle,
        amount: newAmount,
        date: date);

    setState(() {
      _transactions.add(_newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  void _showBottomSheetaddNewTx(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () => {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Transaction> get _recentTransactions {
    return _transactions
        .where(
            (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  List<Widget> _buildPotraitContent(
      Size appBarSize, MediaQueryData mediaQuery, Container txList) {
    return [
      Container(
        width: double.infinity,
        child: Container(
            height: (mediaQuery.size.height -
                    appBarSize.height -
                    mediaQuery.padding.top) *
                0.30,
            child: Chart(_recentTransactions)),
      ),
      txList
    ];
  }

  List<Widget> _buildLandscapeContent(
      Size appBarSize, MediaQueryData mediaQuery, Container txList) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.headline6,
          ),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              width: double.infinity,
              child: Container(
                  height: (mediaQuery.size.height -
                          appBarSize.height -
                          mediaQuery.padding.top) *
                      0.70,
                  child: Chart(_recentTransactions)),
            )
          : txList
    ];
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBarIOS = CupertinoNavigationBar(
      middle: Text('Expense Planner'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => _showBottomSheetaddNewTx(context),
            child: Icon(CupertinoIcons.add),
          ),
        ],
      ),
    );

    final appBarAndroid = AppBar(
      title: Text('Expense Planner'),
      actions: [
        IconButton(
          onPressed: () => _showBottomSheetaddNewTx(context),
          icon: Icon(Icons.add),
        ),
      ],
    );

    final appBarSize =
        Platform.isIOS ? appBarIOS.preferredSize : appBarAndroid.preferredSize;

    var txList = Container(
      height: (mediaQuery.size.height -
              appBarSize.height -
              mediaQuery.padding.top) *
          0.70,
      child: TransactionList(_transactions, _deleteTransaction),
    );

    var pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              ..._buildLandscapeContent(appBarSize, mediaQuery, txList),
            if (!isLandscape)
              ..._buildPotraitContent(appBarSize, mediaQuery, txList),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBarIOS,
          )
        : Scaffold(
            appBar: appBarAndroid,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _showBottomSheetaddNewTx(context)),
            body: pageBody);
  }
}
