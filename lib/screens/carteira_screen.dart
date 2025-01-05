import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'financial_entry_screen.dart';

class CarteiraScreen extends StatelessWidget {
  const CarteiraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: themeProvider.textColor,
          displayColor: themeProvider.textColor,
        ),
      ),
      child: const FinancialEntryScreen(title: 'Carteira', type: 'carteira'),
    );
  }
}

