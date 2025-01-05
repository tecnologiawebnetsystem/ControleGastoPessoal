import 'package:flutter/foundation.dart';
import '../models/financial_entry.dart';

class FinancialProvider extends ChangeNotifier {
  List<FinancialEntry> _entries = [];

  List<FinancialEntry> get entries => _entries;

  void addEntry(FinancialEntry entry) {
    _entries.add(entry);
    notifyListeners();
  }

  void updateEntry(FinancialEntry entry) {
    final index = _entries.indexWhere((e) => e.id == entry.id);
    if (index != -1) {
      _entries[index] = entry;
      notifyListeners();
    }
  }

  void deleteEntry(String id) {
    _entries.removeWhere((entry) => entry.id == id);
    notifyListeners();
  }

  List<FinancialEntry> getEntriesByType(String type) {
    return _entries.where((entry) => entry.type == type).toList();
  }

  double getTotalBalance() {
    return _entries.fold(0, (sum, entry) => 
      sum + (entry.type == 'income' ? entry.amount : -entry.amount));
  }

  double getAccountBalance() {
    return _entries.where((entry) => entry.category == 'conta').fold(0, (sum, entry) => 
      sum + (entry.type == 'income' ? entry.amount : -entry.amount));
  }

  double getSavingsBalance() {
    return _entries.where((entry) => entry.category == 'poupanca').fold(0, (sum, entry) => 
      sum + (entry.type == 'income' ? entry.amount : -entry.amount));
  }

  double getReceivablesBalance() {
    return _entries.where((entry) => entry.type == 'income' && entry.category == 'a receber').fold(0, (sum, entry) => sum + entry.amount);
  }

  List<Map<String, dynamic>> getExpensesByCategory() {
    final expenseCategories = _entries.where((entry) => entry.type == 'expense').map((e) => e.category).toSet();
    return expenseCategories.map((category) {
      final amount = _entries.where((entry) => entry.type == 'expense' && entry.category == category).fold(0.0, (sum, entry) => sum + entry.amount);
      return {'category': category, 'amount': amount};
    }).toList()..sort((a, b) => (b['amount'] as double).compareTo(a['amount'] as double));
  }

  List<FinancialEntry> getRecentTransactions(int count) {
    return _entries.take(count).toList();
  }

  double getTotalIncome() {
    return _entries.where((entry) => entry.type == 'income').fold(0, (sum, entry) => sum + entry.amount);
  }

  double getTotalExpenses() {
    return _entries.where((entry) => entry.type == 'expense').fold(0, (sum, entry) => sum + entry.amount);
  }

  double getTotalSavings() {
    return getTotalIncome() - getTotalExpenses();
  }
}

