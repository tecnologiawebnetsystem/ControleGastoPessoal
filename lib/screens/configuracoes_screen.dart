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
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Personalização',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  _buildColorSection(context, 'Cor Principal', themeProvider.primaryColor, (color) {
                    themeProvider.updateColors(primaryColor: color as MaterialColor);
                  }),
                  _buildColorSection(context, 'Cor do Texto', themeProvider.textColor, (color) {
                    themeProvider.updateColors(textColor: color);
                  }),
                  _buildColorSection(context, 'Cor dos Ícones', themeProvider.iconColor, (color) {
                    themeProvider.updateColors(iconColor: color);
                  }),
                  _buildColorSection(context, 'Cor do Menu', themeProvider.menuColor, (color) {
                    themeProvider.updateColors(menuColor: color);
                  }),
                  _buildColorSection(context, 'Cor Primária do Gráfico', themeProvider.graphPrimaryColor, (color) {
                    themeProvider.updateColors(graphPrimaryColor: color);
                  }),
                  _buildColorSection(context, 'Cor Secundária do Gráfico', themeProvider.graphSecondaryColor, (color) {
                    themeProvider.updateColors(graphSecondaryColor: color);
                  }),
                  const SizedBox(height: 32),
                  _buildPreview(context, themeProvider),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildColorSection(BuildContext context, String title, Color currentColor, Function(Color?) onColorChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...Colors.primaries.map((color) => _buildColorOption(context, color, currentColor, onColorChanged)),
            _buildColorOption(context, Colors.black, currentColor, onColorChanged),
            _buildColorOption(context, Colors.white, currentColor, onColorChanged),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildColorOption(BuildContext context, Color color, Color currentColor, Function(Color?) onColorChanged) {
    final isSelected = color.value == currentColor.value;
    return GestureDetector(
      onTap: () => onColorChanged(color),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: color.withOpacity(0.4), blurRadius: 4, spreadRadius: 1)]
              : null,
        ),
        child: isSelected
            ? const Icon(Icons.check, color: Colors.white, size: 24)
            : null,
      ),
    );
  }

  Widget _buildPreview(BuildContext context, ThemeProvider themeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Prévia',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.palette, color: themeProvider.iconColor),
                    const SizedBox(width: 8),
                    Text(
                      'Elementos principais',
                      style: TextStyle(
                        color: themeProvider.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: themeProvider.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Barra de navegação',
                    style: TextStyle(color: themeProvider.menuColor),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: themeProvider.graphPrimaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Gráfico - Cor Primária',
                          style: TextStyle(color: themeProvider.menuColor),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: themeProvider.graphSecondaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Gráfico - Cor Secundária',
                          style: TextStyle(color: themeProvider.menuColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

