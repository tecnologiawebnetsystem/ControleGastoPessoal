import 'package:flutter/material.dart';
import 'financial_entry_screen.dart';

class LancamentosFuturosScreen extends StatelessWidget {
  const LancamentosFuturosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FinancialEntryScreen(title: 'Lançamentos Futuros', type: 'futuro');
  }
}

