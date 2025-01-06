import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  static const String _baseUrl = 'https://api.exchangerate-api.com/v4/latest/BRL';

  static Future<Map<String, double>> fetchExchangeRates() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'USD': 1 / data['rates']['USD'],
          'EUR': 1 / data['rates']['EUR'],
          'ARS': 1 / data['rates']['ARS'],
        };
      } else {
        throw Exception('Failed to load exchange rates');
      }
    } catch (e) {
      throw Exception('Error fetching exchange rates: $e');
    }
  }
}

