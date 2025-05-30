import 'package:expense_tracker/model/ExpenseModel.dart';
import 'package:expense_tracker/widget/expense.dart';
import 'package:expense_tracker/widget/income.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/incomeModel.dart';

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  //Expense Text field controller
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  //Income text field controller
  TextEditingController incomeController = TextEditingController();
  TextEditingController incomeAmountController = TextEditingController();

  // List for expense categories
  final List<String> categories = [
    'Food',
    'Transport',
    'Entertainment',
    'Bills',
  ];

  final List<String> IncomeType = ['Salary', 'Passive', 'Others'];

  final List<String> type = ['Income', 'Expense'];

  final List<Expense> _expense = [];
  final List<Income> _income = [];

  int _selectedIndex = 0;
  double totalExpense = 0;
  double totalIncome = 0;
  double totalBalance = 0;
  DateTime _expenseTime = DateTime.now();
  DateTime _incomeTime = DateTime.now();

  // add Expense function
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
      totalBalance -= amount;
    });
  }

  // Add Expense bottom Sheet
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
              Text(
                'Add your Expense',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'title'),
              ),
              SizedBox(height: 15),

              TextField(
                controller: amountController,
                decoration: InputDecoration(hintText: 'amount'),
              ),

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

  // add Income function

  void _addIncome(
    String incomeSource,
    double incomeAmount,
    String incomeType,
    DateTime incomeDate,
  ) {
    setState(() {
      _income.add(
        Income(
          incomeSource: incomeSource,
          incomeAmount: incomeAmount,
          incomeType: incomeType,
          incomeDate: incomeDate,
        ),
      );
    });
    totalIncome += incomeAmount;
    totalBalance += incomeAmount;
  }

  //Add income bottomsheet

  void _showIncomeForm(BuildContext context) {
    String incomeType = '';
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add your Income',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              TextField(
                controller: incomeController,
                decoration: InputDecoration(hintText: 'income source'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: incomeAmountController,
                decoration: InputDecoration(hintText: 'amount'),
              ),

              SizedBox(height: 10),

              DropdownButtonFormField(
                items:
                    IncomeType.map(
                      (item) =>
                          DropdownMenuItem(value: item, child: Text(item)),
                    ).toList(),
                onChanged: (value) => incomeType = value!,
                decoration: InputDecoration(labelText: 'Select income type'),
              ),

              SizedBox(height: 10),

              //add income Elevated Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _addIncome(
                      incomeController.text,
                      double.parse(incomeAmountController.text),
                      incomeType,
                      _incomeTime,
                    );
                    incomeController.clear();
                    incomeAmountController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Add income',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
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

  // Show alert dialog

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.grey.shade50,
            alignment: Alignment.center,

            title: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning, color: Colors.red),
                SizedBox(width: 5),
                Text(
                  'Warning',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            content: Text(
              'If you delete all previous history, press "Confirm" otherwise press "Cancel"',
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            actions: [
              ElevatedButton(
                onPressed: () {
                  _deleteHistory();
                  Navigator.pop(context);
                },
                child: Text('Confirm'),
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
              ),

              SizedBox(width: 15),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
              ),
            ],
          ),
    );
  }

  // Delete function
  void _deleteHistory() {
    setState(() {
      _expense.clear();
      _income.clear();
      totalIncome = 0;
      totalExpense = 0;
      totalBalance = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Drawer button Section start
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: DrawerHeader(
                margin: EdgeInsets.all(5),
                child: Text(
                  'Expense Tracker',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ),

            ListTile(
              leading: Text(
                'Add Income',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                _showIncomeForm(context);
              },
            ),

            ListTile(
              leading: Text(
                'Add Expense',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                _showForm(context);
              },
            ),

            ListTile(
              leading: Text(
                'Delete history',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                _showAlertDialog(context);
              },
            ),
          ],
        ),
      ),
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

        actions: [
          IconButton(
            onPressed: () {
              _showIncomeForm(context);
            },
            icon: Icon(Icons.add, color: Colors.white, size: 30),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Card(
                color: Colors.blueAccent.shade200,
                margin: EdgeInsets.all(50),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Total Balance: $totalBalance',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    FittedBox(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Total Income: $totalIncome',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          SizedBox(width: 5),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Total Expense: $totalExpense',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ToggleButtons(
              color: Colors.black,
              constraints: BoxConstraints(minWidth: 120, minHeight: 50),
              fillColor: Colors.blueAccent,
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              selectedColor: Colors.white,
              children: [Text('Income'), Text('Expense')],
              isSelected: [_selectedIndex == 0, _selectedIndex == 1],
              onPressed: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
            SizedBox(height: 15),

            _selectedIndex == 0
                ? income(income: _income)
                : expense(expense: _expense),
          ],
        ),
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
