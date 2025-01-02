import 'package:flutter/material.dart';
import 'financial_entry_screen.dart';

class CarteiraScreen extends StatelessWidget {
  const CarteiraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FinancialEntryScreen(title: 'Carteira', type: 'carteira');
  }
}

