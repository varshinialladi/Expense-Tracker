import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  final List<Transaction> _transactions = [
    //   Transaction(
    //     id: "1",
    //     type: "Expense",
    //     category: "Groceries",
    //     description: "Weekly grocery shopping",
    //     amount: 50,
    //     date: DateTime(2024, 12, 11),
    //     icon: Icons.local_grocery_store,
    //     color: Colors.green[300]!,
    //   ),
    //   Transaction(
    //     id: "2",
    //     type: "Expense",
    //     category: "Electricity",
    //     description: "Monthly electricity bill",
    //     amount: 80,
    //     date: DateTime(2024, 12, 10),
    //     icon: Icons.electrical_services,
    //     color: const Color.fromARGB(255, 184, 190, 110)!,
    //   ),
    //   Transaction(
    //     id: "3",
    //     type: "Expense",
    //     category: "Household",
    //     description: "Cleaning supplies",
    //     amount: 15,
    //     date: DateTime(2024, 12, 9),
    //     icon: Icons.home,
    //     color: Colors.brown,
    //   ),

    //   Transaction(
    //     id: "4",
    //     type: "Expense",
    //     category: "Education",
    //     description: "Textbooks",
    //     amount: 40,
    //     date: DateTime(2024, 12, 8),
    //     icon: Icons.school,
    //     color: Colors.green,
    //   ),
    //   Transaction(
    //     id: "5",
    //     type: "Expense",
    //     category: "Travel",
    //     description: "Bus fare",
    //     amount: 5,
    //     date: DateTime(2024, 12, 7),
    //     icon: Icons.directions_car,
    //     color: Colors.blue,
    //   ),
    //   Transaction(
    //     id: "6",
    //     type: "Expense",
    //     category: "Food",
    //     description: "Lunch at cafeteria",
    //     amount: 10,
    //     date: DateTime(2024, 12, 6),
    //     icon: Icons.fastfood,
    //     color: Colors.orange,
    //   ),

    //   Transaction(
    //     id: "7",
    //     type: "Expense",
    //     category: "Work Expenses",
    //     description: "Office supplies",
    //     amount: 20,
    //     date: DateTime(2024, 12, 5),
    //     icon: Icons.work,
    //     color: Colors.grey,
    //   ),
    //   Transaction(
    //     id: "8",
    //     type: "Expense",
    //     category: "Travel",
    //     description: "Commute to work",
    //     amount: 15,
    //     date: DateTime(2024, 12, 4),
    //     icon: Icons.directions_car,
    //     color: Colors.blue,
    //   ),
    //   Transaction(
    //     id: "9",
    //     type: "Expense",
    //     category: "Bills",
    //     description: "Internet bill",
    //     amount: 60,
    //     date: DateTime(2024, 12, 3),
    //     icon: Icons.receipt,
    //     color: Colors.red,
    //   ),

    //   Transaction(
    //     id: "10",
    //     type: "Income",
    //     category: "Income",
    //     description: "Salary",
    //     amount: 2000,
    //     date: DateTime(2024, 12, 1),
    //     icon: Icons.attach_money,
    //     color: Colors.teal,
    //   ),
    //   Transaction(
    //     id: "11",
    //     type: "Expense",
    //     category: "Entertainment",
    //     description: "Movie tickets",
    //     amount: 25,
    //     date: DateTime(2024, 12, 2),
    //     icon: Icons.movie,
    //     color: Colors.cyan,
    //   ),
  ];

  List<Transaction> get transactions => _transactions;

  double get totalBalance {
    double balance = 0;
    for (var transaction in _transactions) {
      if (transaction.type == "Income") {
        balance += transaction.amount;
      } else {
        balance -= transaction.amount;
      }
    }
    return balance;
  }

  double get totalIncome {
    return _transactions
        .where((transaction) => transaction.type == "Income")
        .fold(0, (sum, transaction) => sum + transaction.amount);
  }

  double get totalExpense {
    return _transactions
        .where((transaction) => transaction.type == "Expense")
        .fold(0, (sum, transaction) => sum + transaction.amount);
  }

  List<double> getWeeklyData(String type) {
    List<double> data = List.filled(7, 0);
    DateTime now = DateTime.now();
    for (var transaction in _transactions) {
      if (transaction.type == type) {
        int dayDiff = now.difference(transaction.date).inDays;
        if (dayDiff >= 0 && dayDiff < 7) {
          int index = 6 - dayDiff;
          data[index] += transaction.amount;
        }
      }
    }
    return data;
  }

  List<double> getMonthlyData(String type) {
    List<double> data = List.filled(4, 0);
    DateTime now = DateTime.now();
    for (var transaction in _transactions) {
      if (transaction.type == type && transaction.date.month == now.month) {
        int week = (transaction.date.day - 1) ~/ 7;
        data[week] += transaction.amount;
      }
    }
    return data;
  }

  List<double> getYearlyData(String type) {
    List<double> data = List.filled(12, 0);
    DateTime now = DateTime.now();
    for (var transaction in _transactions) {
      if (transaction.type == type && transaction.date.year == now.year) {
        int month = transaction.date.month - 1;
        data[month] += transaction.amount;
      }
    }
    return data;
  }

  void addTransaction(Transaction transaction) {
    _transactions.insert(0, transaction);
    notifyListeners();
  }
}
