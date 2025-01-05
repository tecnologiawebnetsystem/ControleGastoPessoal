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

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Visão Geral',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: themeProvider.textColor,
            ),
          ),
          const SizedBox(height: 16),
          _buildSummaryCards(context, financialProvider),
          const SizedBox(height: 32),
          Text(
            'Análise de Despesas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: themeProvider.textColor,
            ),
          ),
          const SizedBox(height: 16),
          _buildExpensesChart(context, financialProvider),
          const SizedBox(height: 32),
          Text(
            'Transações Recentes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: themeProvider.textColor,
            ),
          ),
          const SizedBox(height: 16),
          _buildRecentTransactions(context, financialProvider),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(BuildContext context, FinancialProvider financialProvider) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildSummaryCard(context, 'Saldo Total', financialProvider.getTotalBalance(), Icons.account_balance),
        _buildSummaryCard(context, 'Receitas', financialProvider.getTotalIncome(), Icons.trending_up),
        _buildSummaryCard(context, 'Despesas', financialProvider.getTotalExpenses(), Icons.trending_down),
        _buildSummaryCard(context, 'Economia', financialProvider.getTotalSavings(), Icons.savings),
      ],
    );
  }

  Widget _buildSummaryCard(BuildContext context, String title, double amount, IconData icon) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: themeProvider.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: themeProvider.primaryColor),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: themeProvider.textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'R\$ ${amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeProvider.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpensesChart(BuildContext context, FinancialProvider financialProvider) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final expenses = financialProvider.getExpensesByCategory();
    final totalExpenses = expenses.fold(0.0, (sum, item) => sum + (item['amount'] as double));

    return Container(
      height: 300,
      child: PieChart(
        PieChartData(
          sections: expenses.map((expense) {
            final percentage = (expense['amount'] as double) / totalExpenses;
            return PieChartSectionData(
              color: _getRandomColor(themeProvider),
              value: percentage * 100,
              title: '${(percentage * 100).toStringAsFixed(1)}%',
              radius: 100,
              titleStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: themeProvider.textColor,
              ),
            );
          }).toList(),
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          startDegreeOffset: -90,
        ),
      ),
    );
  }

  Color _getRandomColor(ThemeProvider themeProvider) {
    final List<Color> colors = [
      themeProvider.primaryColor,
      themeProvider.secondaryColor,
      Colors.orange,
      Colors.purple,
      Colors.pink,
    ];
    return colors[DateTime.now().microsecond % colors.length];
  }

  Widget _buildRecentTransactions(BuildContext context, FinancialProvider financialProvider) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final recentTransactions = financialProvider.getRecentTransactions(5);

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: recentTransactions.length,
      itemBuilder: (context, index) {
        final transaction = recentTransactions[index];
        return Card(
          elevation: 2,
          margin: EdgeInsets.only(bottom: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: themeProvider.cardColor,
          child: ListTile(
            leading: Icon(
              transaction.type == 'income' ? Icons.arrow_upward : Icons.arrow_downward,
              color: transaction.type == 'income' ? Colors.green : Colors.red,
            ),
            title: Text(
              transaction.description,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: themeProvider.textColor,
              ),
            ),
            subtitle: Text(
              transaction.category,
              style: TextStyle(color: themeProvider.textSecondaryColor),
            ),
            trailing: Text(
              'R\$ ${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: transaction.type == 'income' ? Colors.green : Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }
}

