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
        title: const Text('Controle Financeiro Pessoal'),
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
              _buildSummaryCards(context, financialProvider),
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

  Widget _buildSummaryCards(BuildContext context, FinancialProvider financialProvider) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final totalBalance = financialProvider.getTotalBalance();
    final accountBalance = financialProvider.getAccountBalance();
    final savingsBalance = financialProvider.getSavingsBalance();
    final receivablesBalance = financialProvider.getReceivablesBalance();

    return Column(
      children: [
        _buildSummaryCard(context, 'Saldo Total', totalBalance, themeProvider),
        const SizedBox(height: 8),
        _buildSummaryCard(context, 'Saldo em Conta', accountBalance, themeProvider),
        const SizedBox(height: 8),
        _buildSummaryCard(context, 'Saldo em Poupança', savingsBalance, themeProvider),
        const SizedBox(height: 8),
        _buildSummaryCard(context, 'Contas a Receber', receivablesBalance, themeProvider),
      ],
    );
  }

  Widget _buildSummaryCard(BuildContext context, String title, double amount, ThemeProvider themeProvider) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, color: themeProvider.textColor),
            ),
            Text(
              'R\$ ${amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: amount >= 0 ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpensesChart(BuildContext context, FinancialProvider financialProvider) {
    final expenses = financialProvider.getExpensesByCategory();
    final maxY = expenses.isNotEmpty ? expenses.map((e) => e['amount'] as double).reduce((a, b) => a > b ? a : b) : 0.0;

    return Container(
      height: 300,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  int index = value.toInt();
                  return index < expenses.length
                      ? Text(
                          expenses[index]['category'] as String,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        )
                      : const Text('');
                },
                reservedSize: 38,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(expenses.length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: expenses[index]['amount'] as double,
                  color: Colors.blue,
                  width: 22,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildRecentTransactions(BuildContext context, FinancialProvider financialProvider) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final recentTransactions = financialProvider.getRecentTransactions(5);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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

