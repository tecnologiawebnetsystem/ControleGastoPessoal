import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../constants/colors.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryCards(),
                const SizedBox(height: 24),
                _buildUpcomingBills(),
                const SizedBox(height: 24),
                _buildUpcomingReceivables(),
                const SizedBox(height: 24),
                _buildMonthlyChart(),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAccountBalances(),
                const SizedBox(height: 24),
                _buildBusinessPromo(),
                const SizedBox(height: 24),
                _buildTopExpenses(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.arrow_circle_up, color: AppColors.expenseRed),
                      SizedBox(width: 8),
                      Text('Contas a Pagar'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'R\$ 5.315,00',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.expenseRed,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.arrow_circle_down, color: AppColors.incomeGreen),
                      SizedBox(width: 8),
                      Text('Contas a Receber'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'R\$ 16.400,00',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.incomeGreen,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingBills() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Próximas Contas a Pagar',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Card(
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildBillItem('20/01', 'Aluguel', 2100.00),
              _buildBillItem('10/01', 'TV a Cabo', 250.00),
              _buildBillItem('10/01', 'Luz', 200.00),
              _buildBillItem('10/01', 'Agua', 121.00),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingReceivables() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Próximas Contas a Receber',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Card(
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildBillItem('07/01', 'Alelo', 3100.00),
              _buildBillItem('08/01', 'Claro', 7000.00),
              _buildBillItem('10/01', 'HDI', 11000.00),
              _buildBillItem('15/01', 'CoreOn', 5900.00),
              _buildBillItem('20/01', 'CoreOn', 2000.00),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBillItem(String date, String description, double value) {
    return ListTile(
      title: Text(description),
      subtitle: Text(date),
      trailing: Text(
        'R\$ ${value.toStringAsFixed(2)}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }



  Widget _buildMonthlyChart() {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Movimentações por Mês 2025',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 4000,
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const titles = ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'];
                              if (value.toInt() < 0 || value.toInt() >= titles.length) return const Text('');
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  titles[value.toInt()],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                'R\$ ${value.toInt()}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                            reservedSize: 60,
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 1000,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.grey.withOpacity(0.2),
                            strokeWidth: 1,
                          );
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: [
                        _createBarGroup(0, 500, 1200, themeProvider),
                        _createBarGroup(1, 2000, 1800, themeProvider),
                        _createBarGroup(2, 1500, 1700, themeProvider),
                        _createBarGroup(3, 2000, 2000, themeProvider),
                        _createBarGroup(4, 1800, 2200, themeProvider),
                        _createBarGroup(5, 1500, 2000, themeProvider),
                        _createBarGroup(6, 2000, 3200, themeProvider),
                        _createBarGroup(7, 2500, 2800, themeProvider),
                        _createBarGroup(8, 2200, 2600, themeProvider),
                        _createBarGroup(9, 1000, 2800, themeProvider),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  BarChartGroupData _createBarGroup(int x, double expense, double income, ThemeProvider themeProvider) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: expense,
          color: themeProvider.graphSecondaryColor,
          width: 16,
        ),
        BarChartRodData(
          toY: income,
          color: themeProvider.graphPrimaryColor,
          width: 16,
        ),
      ],
    );
  }

  Widget _buildAccountBalances() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Saldo em Contas',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              _buildBalanceItem('Poupança', 8500.00),
              const Divider(),
              _buildBalanceItem('Carteira', 4931.00),
              const Divider(),
              _buildTotalBalance(13431.00),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceItem(String title, double value) {
    return ListTile(
      title: Text(title),
      trailing: Text(
        'R\$ ${value.toStringAsFixed(2)}',
        style: const TextStyle(
          color: AppColors.primaryBlue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTotalBalance(double total) {
    return ListTile(
      title: const Text(
        'Total',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        'R\$ ${total.toStringAsFixed(2)}',
        style: const TextStyle(
          color: AppColors.primaryBlue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBusinessPromo() {
    return Card(
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.business_center,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Tech One',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text(
          'Conheça nossos aplicativos para sua empresa',
        ),
      ),
    );
  }

  Widget _buildTopExpenses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Maiores Despesas do Mês',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              _buildExpenseItem('Moradia', 470.00),
              _buildExpenseItem('Alimentação', 235.00),
              _buildExpenseItem('Outras Despesas', 200.00),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpenseItem(String category, double value) {
    return ListTile(
      title: Text(category),
      trailing: Text(
        'R\$ ${value.toStringAsFixed(2)}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

