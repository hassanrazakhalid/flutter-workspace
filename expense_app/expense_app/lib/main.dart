import 'package:expense_app/widgets/chart.dart';
import 'package:expense_app/widgets/new_transaction.dart';
import 'package:flutter/services.dart';

import 'models/transaction.dart';
import 'package:flutter/material.dart';
import './widgets/user_transactions.dart';
import 'widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                  titleSmall: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
            ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver  {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: '1', title: 'New Shoes', amount: 59.87, date: DateTime.now()),
    // Transaction(
    //     id: '2', title: 'Week grocery', amount: 49.87, date: DateTime.now()),
  ];

  List<Transaction> get _recenetTransactions {
    return _userTransactions
        .where((x) => x.date.isAfter(DateTime.now().subtract(Duration(
              days: 7,
            ))))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) { 

  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  _newTransactionAdded(String title, double price) {
    var transaction = Transaction(
      id: DateTime.now().toString(),
      amount: price,
      title: title,
      date: DateTime.now(),
    );

    setState(
      () => {
        _userTransactions.add(transaction),
      },
    );
  }

  void startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            // onTap: () {},
            // behavior: HitTestBehavior.opaque,
            child: NewTransaction(transactionAdded: _newTransactionAdded),
          );
        });
  }
 
  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
        title: Text('Expense App'),
        actions: [
          IconButton(
            onPressed: () {
              startNewTransaction(context);
            },
            icon: Icon(Icons.add),
          )
        ],
      );
    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          startNewTransaction(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: (MediaQuery.of(context).size.height * 0.3) - MediaQuery.of(context).padding.top - appBar.preferredSize.height,
              padding: EdgeInsets.zero,
              width: double.infinity,
              child: Chart(
                recentTransactions: _recenetTransactions,
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height * 0.7) - MediaQuery.of(context).padding.top - appBar.preferredSize.height,
              child: TransactionList(_userTransactions)),
          ],
        ),
      ),
    );
  }
}
