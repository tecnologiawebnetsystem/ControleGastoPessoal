import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../providers/theme_provider.dart';
import 'package:provider/provider.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  Map<String, dynamic>? _weatherData;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final weather = await WeatherService.getWeather('São Paulo'); // Você pode alterar para a cidade desejada
      setState(() {
        _weatherData = weather;
      });
      _updateThemeBasedOnWeather();
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }

  void _updateThemeBasedOnWeather() {
    if (_weatherData != null) {
      final condition = _weatherData!['weather'][0]['main'].toLowerCase();
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      
      if (condition.contains('clear')) {
        themeProvider.setThemeColor(Colors.yellow[700]!);
      } else if (condition.contains('cloud')) {
        themeProvider.setThemeColor(Colors.grey[400]!);
      } else if (condition.contains('rain')) {
        themeProvider.setThemeColor(Colors.blue[700]!);
      } else if (condition.contains('snow')) {
        themeProvider.setThemeColor(Colors.lightBlue[100]!);
      } else {
        themeProvider.setThemeColor(Colors.teal);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    if (_weatherData == null) {
      return Center(child: CircularProgressIndicator());
    }

    final temp = _weatherData!['main']['temp'];
    final condition = _weatherData!['weather'][0]['main'];
    final icon = _weatherData!['weather'][0]['icon'];

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: themeProvider.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Previsão do Tempo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: themeProvider.textColor,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'http://openweathermap.org/img/w/$icon.png',
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 8),
                Text(
                  '${temp.toStringAsFixed(1)}°C',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.textColor,
                  ),
                ),
              ],
            ),
            Text(
              condition,
              style: TextStyle(
                fontSize: 16,
                color: themeProvider.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

