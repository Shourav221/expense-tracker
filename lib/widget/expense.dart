import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/ExpenseModel.dart';

class expense extends StatelessWidget {
  const expense({
    super.key,
    required List<Expense> expense,
  }) : _expense = expense;

  final List<Expense> _expense;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _expense.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: FittedBox(child: Text(_expense[index].category)),
              ),

              title: Text(
                _expense[index].title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              subtitle: Text(
                DateFormat.yMMMEd().format(_expense[index].date),
              ),

              trailing: Text(
                ('- ${_expense[index].amount.toString()}'),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}