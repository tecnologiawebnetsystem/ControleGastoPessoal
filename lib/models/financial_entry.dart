import 'package:uuid/uuid.dart';

class FinancialEntry {
  final String id;
  String description;
  double amount;
  DateTime date;
  String category;
  String type; // 'income' ou 'expense'

  FinancialEntry({
    String? id,
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
    required this.type,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category,
      'type': type,
    };
  }

  factory FinancialEntry.fromMap(Map<String, dynamic> map) {
    return FinancialEntry(
      id: map['id'],
      description: map['description'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      category: map['category'],
      type: map['type'],
    );
  }
}

