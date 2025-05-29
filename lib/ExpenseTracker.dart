import 'package:expense_tracker/ExpenseModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final List<String> categories = [
    'Food',
    'Transport',
    'Entertainment',
    'Bills',
  ];

  final List<Expense> _expense = [];

  double totalExpense = 0;
  DateTime _expenseTime = DateTime.now();

  void _addExpense(
    String title,
    double amount,
    String category,
    DateTime date,
  ) {
    setState(() {
      _expense.add(
        Expense(title: title, amount: amount, category: category, date: date),
      );
      totalExpense += amount;
    });
  }

  void _showForm(BuildContext context) {
    String selectCategory = '';
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'title'),
              ),
              SizedBox(height: 15),

              TextField(
                controller: amountController,
                decoration: InputDecoration(hintText: 'amount'),
              ),

              SizedBox(height: 20),

              DropdownButtonFormField(
                items:
                    categories
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ),
                        )
                        .toList(),
                onChanged: (value) => selectCategory = value!,
                decoration: InputDecoration(labelText: 'select any one'),
              ),
              SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _addExpense(
                      titleController.text,
                      double.parse(amountController.text),
                      selectCategory,
                      _expenseTime,
                    );
                    titleController.clear();
                    amountController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Add Expense',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text(
          'Expense Tracker',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Card(
              color: Colors.blueAccent.shade200,
              margin: EdgeInsets.all(50),
              child: Padding(
                padding: EdgeInsets.all(50),
                child: Text(
                  'Total: $totalExpense',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
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
                      (_expense[index].amount.toString()),
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
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          _showForm(context);
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
