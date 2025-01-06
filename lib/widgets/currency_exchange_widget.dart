import 'package:flutter/material.dart';
import '../services/currency_service.dart';
import '../providers/theme_provider.dart';
import 'package:provider/provider.dart';

class CurrencyExchangeWidget extends StatefulWidget {
  const CurrencyExchangeWidget({Key? key}) : super(key: key);

  @override
  _CurrencyExchangeWidgetState createState() => _CurrencyExchangeWidgetState();
}

class _CurrencyExchangeWidgetState extends State<CurrencyExchangeWidget> {
  Map<String, double> _exchangeRates = {};
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchExchangeRates();
  }

  Future<void> _fetchExchangeRates() async {
    try {
      final rates = await CurrencyService.fetchExchangeRates();
      setState(() {
        _exchangeRates = rates;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao carregar cotações: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode ? Colors.grey[800] : Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cotações',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          if (_isLoading)
            const CircularProgressIndicator()
          else if (_errorMessage.isNotEmpty)
            Text(_errorMessage, style: TextStyle(color: Colors.red))
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildExchangeRateCard('USD', 'Dólar', themeProvider),
                _buildExchangeRateCard('EUR', 'Euro', themeProvider),
                _buildExchangeRateCard('ARS', 'Peso Argentino', themeProvider),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildExchangeRateCard(String currency, String currencyName, ThemeProvider themeProvider) {
    return Expanded(
      child: Card(
        color: themeProvider.isDarkMode ? Colors.grey[700] : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currencyName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '1 $currency = R\$ ${_exchangeRates[currency]?.toStringAsFixed(2) ?? "N/A"}',
                style: TextStyle(
                  fontSize: 16,
                  color: themeProvider.isDarkMode ? Colors.white70 : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

