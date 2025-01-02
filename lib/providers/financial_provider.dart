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
}

