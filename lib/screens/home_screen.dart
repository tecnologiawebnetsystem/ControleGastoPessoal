import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/dashboard_content.dart';
import 'carteira_screen.dart';
import 'poupanca_screen.dart';
import 'lancamentos_futuros_screen.dart';
import 'contas_a_pagar_screen.dart';
import 'contas_a_receber_screen.dart';
import 'configuracoes_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const DashboardContent(),
    const CarteiraScreen(),
    const PoupancaScreen(),
    const LancamentosFuturosScreen(),
    const ContasAPagarScreen(),
    const ContasAReceberScreen(),
    const ConfiguracoesScreen(),
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemSelected,
            extended: MediaQuery.of(context).size.width > 1200,
            backgroundColor: themeProvider.primaryColor,
            selectedLabelTextStyle: TextStyle(color: themeProvider.menuColor),
            unselectedLabelTextStyle: TextStyle(color: themeProvider.menuColor.withOpacity(0.7)),
            selectedIconTheme: IconThemeData(color: themeProvider.menuColor),
            unselectedIconTheme: IconThemeData(color: themeProvider.menuColor),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.account_balance_wallet),
                label: Text('Carteira'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.savings),
                label: Text('Poupança'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.calendar_today),
                label: Text('Lançamentos Futuros'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.money_off),
                label: Text('Contas a Pagar'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.attach_money),
                label: Text('Contas a Receber'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('Configurações'),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: themeProvider.cardColor,
                  elevation: 0,
                  title: Text(
                    'Controle Gasto Pessoal',
                    style: TextStyle(color: themeProvider.textColor),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.brightness_6, color: themeProvider.iconColor),
                      onPressed: () {
                        themeProvider.toggleTheme();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.exit_to_app, color: themeProvider.iconColor),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: _widgetOptions.elementAt(_selectedIndex),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

