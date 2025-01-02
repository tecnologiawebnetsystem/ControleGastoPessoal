import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  MaterialColor _primaryColor = Colors.blue;
  Color _textColor = Colors.black87;
  Color _iconColor = Colors.blue;
  Color _menuColor = Colors.white;
  Color _graphPrimaryColor = Colors.blue;
  Color _graphSecondaryColor = Colors.red;

  static const String _primaryColorKey = 'primary_color';
  static const String _textColorKey = 'text_color';
  static const String _iconColorKey = 'icon_color';
  static const String _menuColorKey = 'menu_color';
  static const String _graphPrimaryColorKey = 'graph_primary_color';
  static const String _graphSecondaryColorKey = 'graph_secondary_color';

  ThemeProvider() {
    _loadSavedColors();
  }

  MaterialColor get primaryColor => _primaryColor;
  Color get textColor => _textColor;
  Color get iconColor => _iconColor;
  Color get menuColor => _menuColor;
  Color get graphPrimaryColor => _graphPrimaryColor;
  Color get graphSecondaryColor => _graphSecondaryColor;

  MaterialColor _createMaterialColor(Color color) {
    List<double> strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  void updateColors({
    MaterialColor? primaryColor,
    Color? textColor,
    Color? iconColor,
    Color? menuColor,
    Color? graphPrimaryColor,
    Color? graphSecondaryColor,
  }) {
    if (primaryColor != null) _primaryColor = primaryColor;
    if (textColor != null) _textColor = textColor;
    if (iconColor != null) _iconColor = iconColor;
    if (menuColor != null) _menuColor = menuColor;
    if (graphPrimaryColor != null) _graphPrimaryColor = graphPrimaryColor;
    if (graphSecondaryColor != null) _graphSecondaryColor = graphSecondaryColor;

    notifyListeners();
    _saveColors();
  }

  Future<void> _loadSavedColors() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Load primary color with fallback
      final primaryColorValue = prefs.getInt(_primaryColorKey);
      if (primaryColorValue != null) {
        _primaryColor = _createMaterialColor(Color(primaryColorValue));
      }

      // Load other colors with fallbacks
      _textColor = Color(prefs.getInt(_textColorKey) ?? Colors.black87.value);
      _iconColor = Color(prefs.getInt(_iconColorKey) ?? Colors.blue.value);
      _menuColor = Color(prefs.getInt(_menuColorKey) ?? Colors.white.value);
      _graphPrimaryColor = Color(prefs.getInt(_graphPrimaryColorKey) ?? Colors.blue.value);
      _graphSecondaryColor = Color(prefs.getInt(_graphSecondaryColorKey) ?? Colors.red.value);

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading saved colors: $e');
      // Use default colors if there's an error
      _primaryColor = Colors.blue;
      _textColor = Colors.black87;
      _iconColor = Colors.blue;
      _menuColor = Colors.white;
      _graphPrimaryColor = Colors.blue;
      _graphSecondaryColor = Colors.red;
    }
  }

  Future<void> _saveColors() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_primaryColorKey, _primaryColor.value);
      await prefs.setInt(_textColorKey, _textColor.value);
      await prefs.setInt(_iconColorKey, _iconColor.value);
      await prefs.setInt(_menuColorKey, _menuColor.value);
      await prefs.setInt(_graphPrimaryColorKey, _graphPrimaryColor.value);
      await prefs.setInt(_graphSecondaryColorKey, _graphSecondaryColor.value);
    } catch (e) {
      debugPrint('Error saving colors: $e');
    }
  }
}