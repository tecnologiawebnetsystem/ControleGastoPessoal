import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'carteira_screen.dart';
import 'poupanca_screen.dart';
import 'lancamentos_futuros_screen.dart';
import 'contas_a_pagar_screen.dart';
import 'contas_a_receber_screen.dart';
import 'configuracoes_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Caixinha - Orçamento Pessoal'),
        backgroundColor: themeProvider.primaryColor,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration:BoxDecoration(
                color: themeProvider.primaryColor,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: themeProvider.menuColor,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet, color: themeProvider.iconColor),
              title: Text('Carteira', style: TextStyle(color: themeProvider.textColor)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CarteiraScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.savings, color: themeProvider.iconColor),
              title: Text('Poupança', style: TextStyle(color: themeProvider.textColor)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PoupancaScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today, color: themeProvider.iconColor),
              title: Text('Lançamentos Futuros', style: TextStyle(color: themeProvider.textColor)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LancamentosFuturosScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.money_off, color: themeProvider.iconColor),
              title: Text('Contas a Pagar', style: TextStyle(color: themeProvider.textColor)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ContasAPagarScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_money, color: themeProvider.iconColor),
              title: Text('Contas a Receber', style: TextStyle(color: themeProvider.textColor)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ContasAReceberScreen()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings, color: themeProvider.iconColor),
              title: Text('Configurações', style: TextStyle(color: themeProvider.textColor)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ConfiguracoesScreen()));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Bem-vindo ao Caixinha!',
          style: TextStyle(
            fontSize: 24,
            color: themeProvider.textColor,
          ),
        ),
      ),
    );
  }
}

