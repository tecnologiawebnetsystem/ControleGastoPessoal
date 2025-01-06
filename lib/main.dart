import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'providers/theme_provider.dart';
import 'providers/financial_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => FinancialProvider()),
      ],
      child: const CaixinhaApp(),
    ),
  );
}

class CaixinhaApp extends StatelessWidget {
  const CaixinhaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Orçamento Pessoal',
          theme: ThemeData(
            primaryColor: themeProvider.primaryColor,
            scaffoldBackgroundColor: themeProvider.backgroundColor,
            cardColor: themeProvider.cardColor,
            textTheme: Theme.of(context).textTheme.apply(
              bodyColor: themeProvider.textColor,
              displayColor: themeProvider.textColor,
            ),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: themeProvider.primaryColor,
              secondary: themeProvider.secondaryColor,
              brightness: themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: themeProvider.primaryColor,
              foregroundColor: themeProvider.menuColor,
            ),
            iconTheme: IconThemeData(color: themeProvider.iconColor),
          ),
          home: const LoginScreen(),
        );
      },
    );
  }
}

