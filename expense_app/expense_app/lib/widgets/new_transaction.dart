import 'package:flutter/material.dart';
import '../models/transaction.dart';

class NewTransaction extends StatefulWidget {
  final Function(String, double) transactionAdded;

  NewTransaction({required this.transactionAdded});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  String titleInput = '';

  String amountInput = '';

  final TextEditingController titleController = new TextEditingController();

  final TextEditingController amountController = new TextEditingController();

  void _submitCalled() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

if(title.isEmpty || amount < 0) {
  return;
}
    widget.transactionAdded(title, amount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: MediaQuery.of(context).viewInsets.bottom + 5,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                onSubmitted: (_) => _submitCalled(),
                onChanged: (value) => {titleInput = value},
              ),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitCalled(),
                onChanged: (text) => {amountInput = text},
              ),
              TextButton(
                child: Text('Add transaction'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.purple,
                ),
                onPressed: _submitCalled,
              )
            ],
          ),
        ),
      ),
    );
  }
}
