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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            labelType: NavigationRailLabelType.all,
            backgroundColor: themeProvider.primaryColor,
            selectedLabelTextStyle: TextStyle(color: themeProvider.menuColor),
            unselectedLabelTextStyle: TextStyle(color: themeProvider.menuColor.withOpacity(0.5)),
            selectedIconTheme: IconThemeData(color: themeProvider.menuColor),
            unselectedIconTheme: IconThemeData(color: themeProvider.menuColor.withOpacity(0.5)),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text('Menu'),
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
                label: Text('Futuros'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.money_off),
                label: Text('A Pagar'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.attach_money),
                label: Text('A Receber'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('Configurações'),
              ),
            ],
          ),
          Expanded(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
    );
  }
}

