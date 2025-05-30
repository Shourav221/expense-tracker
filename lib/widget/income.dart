import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/incomeModel.dart';

class income extends StatelessWidget {
  const income({
    super.key,
    required List<Income> income,
  }) : _income = income;

  final List<Income> _income;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: ListView.builder(
          itemCount: _income.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: FittedBox(
                  child: Text(_income[index].incomeType),
                ),
              ),

              title: Text(
                _income[index].incomeSource,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              subtitle: Text(
                DateFormat.yMMMEd().format(
                  _income[index].incomeDate,
                ),
              ),

              trailing: Text(
                '+ ${_income[index].incomeAmount.toString()}',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
