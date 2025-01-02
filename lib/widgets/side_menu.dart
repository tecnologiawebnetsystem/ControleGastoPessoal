import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../screens/configuracoes_screen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildMenuItem(Icons.account_circle_outlined, 'Contas', isSelected: true),
          _buildSubMenuItem(Icons.account_balance_wallet, 'Carteira'),
          _buildSubMenuItem(Icons.savings_outlined, 'Poupança'),
          const Divider(),
          _buildMenuItem(Icons.calendar_today_outlined, 'Lançamentos Futuros'),
          _buildMenuItem(Icons.arrow_circle_up_outlined, 'Contas a Pagar'),
          _buildMenuItem(Icons.arrow_circle_down_outlined, 'Contas a Receber'),
          const Spacer(),
          _buildConfigMenuItem(context),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {bool isSelected = false}) {
    return ListTile(
      leading: Icon(icon, 
        color: isSelected ? AppColors.primaryBlue : AppColors.textSecondary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.primaryBlue : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onTap: () {},
    );
  }

  Widget _buildConfigMenuItem(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.settings, color: AppColors.textSecondary),
      title: Text(
        'Configurações',
        style: TextStyle(
          color: AppColors.textSecondary,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ConfiguracoesScreen()),
        );
      },
    );
  }

  Widget _buildSubMenuItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0),
      child: ListTile(
        leading: Icon(icon, color: AppColors.textSecondary),
        title: Text(title),
        dense: true,
        onTap: () {},
      ),
    );
  }
}

