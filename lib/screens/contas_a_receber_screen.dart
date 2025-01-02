import 'package:flutter/material.dart';
import 'financial_entry_screen.dart';

class ContasAReceberScreen extends StatelessWidget {
  const ContasAReceberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FinancialEntryScreen(title: 'Contas a Receber', type: 'receita');
  }
}

