import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class ConfiguracoesScreen extends StatelessWidget {
  const ConfiguracoesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Configurações'),
            backgroundColor: themeProvider.primaryColor,
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSection(
                context,
                'Aparência',
                [
                  _buildThemeToggle(context, themeProvider),
                ],
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                'Informações do Aplicativo',
                [
                  _buildInfoTile('Versão', '1.0.0'),
                  _buildInfoTile('Desenvolvido por', 'Sua Empresa'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildThemeToggle(BuildContext context, ThemeProvider themeProvider) {
    return SwitchListTile(
      title: const Text('Modo Escuro'),
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        themeProvider.toggleTheme();
      },
      secondary: Icon(
        themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return ListTile(
      title: Text(title),
      trailing: Text(value),
    );
  }
}

