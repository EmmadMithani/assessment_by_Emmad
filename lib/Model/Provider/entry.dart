import 'package:flutter/material.dart';

class EntryItem with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String date;
  final String time;
  final String expense;
  final double amount;

  EntryItem(
      {required this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.time,
      required this.expense,
      required this.amount});
}

class Entry with ChangeNotifier {
  List<EntryItem> _items = [];

  List<EntryItem> get items {
    return [..._items];
  }

  void addNewEntry(EntryItem value) {
    _items.add(value);
    notifyListeners();
  }

  double getTotalExpense() {
    double totalExpense = 0;

    for (var element in _items) {
      if (element.expense == "Expense") totalExpense += element.amount;
    }
    return totalExpense;
  }

  double getTotalIncome() {
    double totalExpense = 0;

    for (var element in _items) {
      if (element.expense == "Income") totalExpense += element.amount;
    }
    return totalExpense;
  }

  void clearAll() {
    _items.clear();
    notifyListeners();
  }
}
