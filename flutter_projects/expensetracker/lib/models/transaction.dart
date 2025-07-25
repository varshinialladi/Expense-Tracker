import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String type; // "Income" or "Expense"
  final String category;
  final String description;
  final double amount;
  final DateTime date;
  final IconData icon;
  final Color color;

  Transaction({
    required this.id,
    required this.type,
    required this.category,
    required this.description,
    required this.amount,
    required this.date,
    required this.icon,
    required this.color,
  });
}
