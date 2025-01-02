import 'package:flutter/material.dart';
import 'financial_entry_screen.dart';

class ContasAPagarScreen extends StatelessWidget {
  const ContasAPagarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FinancialEntryScreen(title: 'Contas a Pagar', type: 'despesa');
  }
}

