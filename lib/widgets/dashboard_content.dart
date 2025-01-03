import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/financial_provider.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final financialProvider = Provider.of<FinancialProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: themeProvider.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Resumo Financeiro',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: themeProvider.textColor),
              ),
              const SizedBox(height: 16),
              _buildSummaryCard(context, financialProvider),
              const SizedBox(height: 24),
              Text(
                'Gráfico de Despesas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: themeProvider.textColor),
              ),
              const SizedBox(height: 16),
              _buildExpensesChart(context, financialProvider),
              const SizedBox(height: 24),
              Text(
                'Transações Recentes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: themeProvider.textColor),
              ),
              const SizedBox(height: 16),
              _buildRecentTransactions(context, financialProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, FinancialProvider financialProvider) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final totalBalance = financialProvider.getTotalBalance();

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Saldo Total',
              style: TextStyle(fontSize: 18, color: themeProvider.textColor),
            ),
            const SizedBox(height: 8),
            Text(
              'R\$ ${totalBalance.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: totalBalance >= 0 ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpensesChart(BuildContext context, FinancialProvider financialProvider) {
    // Implemente o gráfico de despesas aqui usando fl_chart
    return Container(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: Colors.red,
              value: 30,
              title: 'Moradia',
              radius: 50,
            ),
            PieChartSectionData(
              color: Colors.blue,
              value: 20,
              title: 'Alimentação',
              radius: 50,
            ),
            PieChartSectionData(
              color: Colors.green,
              value: 15,
              title: 'Transporte',
              radius: 50,
            ),
            PieChartSectionData(
              color: Colors.yellow,
              value: 35,
              title: 'Outros',
              radius: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTransactions(BuildContext context, FinancialProvider financialProvider) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final recentTransactions = financialProvider.entries.take(5).toList();

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: recentTransactions.length,
      itemBuilder: (context, index) {
        final transaction = recentTransactions[index];
        return ListTile(
          leading: Icon(
            transaction.type == 'income' ? Icons.arrow_upward : Icons.arrow_downward,
            color: transaction.type == 'income' ? Colors.green : Colors.red,
          ),
          title: Text(transaction.description),
          subtitle: Text(transaction.category),
          trailing: Text(
            'R\$ ${transaction.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: transaction.type == 'income' ? Colors.green : Colors.red,
            ),
          ),
        );
      },
    );
  }
}

