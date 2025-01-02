import 'package:flutter/material.dart';
import 'financial_entry_screen.dart';

class PoupancaScreen extends StatelessWidget {
  const PoupancaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FinancialEntryScreen(title: 'Poupança', type: 'poupanca');
  }
}

