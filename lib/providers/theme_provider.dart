import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  Color get primaryColor => _isDarkMode ? Colors.tealAccent[700]! : Colors.teal;
  Color get textColor => _isDarkMode ? Colors.white : Colors.black87;
  Color get menuColor => Colors.white;
  Color get iconColor => _isDarkMode ? Colors.white : Colors.black87;
  Color get backgroundColor => _isDarkMode ? Color(0xFF121212) : Colors.grey[100]!;
  Color get cardColor => _isDarkMode ? Color(0xFF1E1E1E) : Colors.white;
  Color get secondaryColor => _isDarkMode ? Colors.tealAccent[400]! : Colors.teal[300]!;
  Color get textSecondaryColor => _isDarkMode ? Colors.grey[300]! : Colors.grey[700]!;
}

