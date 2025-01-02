import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class OrcamentoScreen extends StatelessWidget {
  const OrcamentoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildContasSection(),
                      const SizedBox(height: 20),
                      _buildProximasContasSection(),
                      const SizedBox(height: 20),
                      _buildGraficoMovimentacoes(),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSaldoEmConta(),
                      const SizedBox(height: 20),
                      _buildMaioresDespesas(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContasSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Resumo'),
        const SizedBox(height: 10),
        _buildContaItem('Contas a Pagar', 1500.00, Colors.red),
        const SizedBox(height: 10),
        _buildContaItem('Contas a Receber', 2000.00, Colors.green),
      ],
    );
  }

  Widget _buildContaItem(String title, double value, Color color) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            'R\$ ${value.toStringAsFixed(2)}',
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildProximasContasSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Próximas Contas'),
        const SizedBox(height: 10),
        _buildProximaContaList('Próximas Contas a Pagar', [
          {'descricao': 'Aluguel', 'valor': 800.00, 'data': '05/06/2023'},
          {'descricao': 'Energia', 'valor': 150.00, 'data': '10/06/2023'},
        ]),
        const SizedBox(height: 10),
        _buildProximaContaList('Próximos Valores a Receber', [
          {'descricao': 'Salário', 'valor': 3000.00, 'data': '05/06/2023'},
          {'descricao': 'Freelance', 'valor': 500.00, 'data': '15/06/2023'},
        ]),
      ],
    );
  }

  Widget _buildProximaContaList(String title, List<Map<String, dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text('${item['descricao']} - R\$ ${item['valor'].toStringAsFixed(2)} - ${item['data']}'),
        )),
      ],
    );
  }

  Widget _buildGraficoMovimentacoes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Movimentações Mensais'),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              minX: 0,
              maxX: 6,
              minY: 0,
              maxY: 6,
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    const FlSpot(0, 3),
                    const FlSpot(1, 1),
                    const FlSpot(2, 4),
                    const FlSpot(3, 2),
                    const FlSpot(4, 5),
                    const FlSpot(5, 1),
                  ],
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 3,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaldoEmConta() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Saldo em Conta'),
        const SizedBox(height: 10),
        _buildSaldoItem('Conta Corrente', 5000.00),
        const SizedBox(height: 5),
        _buildSaldoItem('Conta Poupança', 10000.00),
      ],
    );
  }

  Widget _buildSaldoItem(String title, double value) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            'R\$ ${value.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildMaioresDespesas() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Maiores Despesas do Mês'),
        const SizedBox(height: 10),
        _buildDespesaItem('Aluguel', 800.00),
        _buildDespesaItem('Supermercado', 600.00),
        _buildDespesaItem('Energia', 150.00),
      ],
    );
  }

  Widget _buildDespesaItem(String descricao, double valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text('$descricao - R\$ ${valor.toStringAsFixed(2)}'),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

