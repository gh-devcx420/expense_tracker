import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

enum Category { work, leisure, food, travel }

final formatter = DateFormat('dd MMM yyyy');

final categoryIcons = {
  Category.work: Icons.work,
  Category.leisure: Icons.beach_access_rounded,
  Category.food: Icons.fastfood,
  Category.travel: Icons.directions_bus,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.expenseCategory,
    required this.expenseDate,
  }) : id = const Uuid().v4();

  String id;
  String title;
  double amount;
  Category expenseCategory;
  DateTime expenseDate;

  String getFormattedDate(DateTime date) {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket(this.expenses, this.category);

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses.where((expense) {
          return expense.expenseCategory == category;
        }).toList();

  List<Expense> expenses;
  Category category;

  double get totalExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
