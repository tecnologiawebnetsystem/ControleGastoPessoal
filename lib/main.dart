import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
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
            primarySwatch: themeProvider.primaryColor,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              backgroundColor: themeProvider.primaryColor,
              elevation: 0,
              iconTheme: IconThemeData(color: themeProvider.menuColor),
              titleTextStyle: TextStyle(
                color: themeProvider.menuColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            textTheme: Theme.of(context).textTheme.apply(
              bodyColor: themeProvider.textColor,
              displayColor: themeProvider.textColor,
            ),
            iconTheme: IconThemeData(color: themeProvider.iconColor),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}

