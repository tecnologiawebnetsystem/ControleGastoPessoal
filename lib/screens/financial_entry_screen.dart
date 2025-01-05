import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/financial_entry.dart';
import '../providers/financial_provider.dart';
import '../providers/theme_provider.dart';

class FinancialEntryScreen extends StatefulWidget {
  final String title;
  final String type;

  const FinancialEntryScreen({Key? key, required this.title, required this.type}) : super(key: key);

  @override
  _FinancialEntryScreenState createState() => _FinancialEntryScreenState();
}

class _FinancialEntryScreenState extends State<FinancialEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _description;
  late double _amount;
  late String _category;
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final financialProvider = Provider.of<FinancialProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: themeProvider.primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: financialProvider.getEntriesByType(widget.type).length,
              itemBuilder: (context, index) {
                final entry = financialProvider.getEntriesByType(widget.type)[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: themeProvider.cardColor,
                  child: ListTile(
                    title: Text(
                      entry.description,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: themeProvider.textColor,
                      ),
                    ),
                    subtitle: Text(
                      '${entry.category} - ${entry.date.toString().split(' ')[0]}',
                      style: TextStyle(color: themeProvider.textSecondaryColor),
                    ),
                    trailing: Text(
                      'R\$ ${entry.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: entry.type == 'income' ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () => _showEntryDialog(entry),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: Text('Adicionar ${widget.title}'),
              onPressed: () => _showEntryDialog(null),
              style: ElevatedButton.styleFrom(
                backgroundColor: themeProvider.primaryColor,
                foregroundColor: themeProvider.menuColor,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEntryDialog(FinancialEntry? entry) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: themeProvider.cardColor,
          title: Text(
            entry == null ? 'Adicionar ${widget.title}' : 'Editar ${widget.title}',
            style: TextStyle(color: themeProvider.textColor),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: entry?.description,
                    decoration: InputDecoration(
                      labelText: 'Descrição',
                      labelStyle: TextStyle(color: themeProvider.textSecondaryColor),
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: themeProvider.textSecondaryColor),
                      ),
                    ),
                    style: TextStyle(color: themeProvider.textColor),
                    validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                    onSaved: (value) => _description = value!,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: entry?.amount.toString(),
                    decoration: InputDecoration(
                      labelText: 'Valor',
                      labelStyle: TextStyle(color: themeProvider.textSecondaryColor),
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: themeProvider.textSecondaryColor),
                      ),
                      prefixText: 'R\$ ',
                      prefixStyle: TextStyle(color: themeProvider.textColor),
                    ),
                    style: TextStyle(color: themeProvider.textColor),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                    onSaved: (value) => _amount = double.parse(value!),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: entry?.category,
                    decoration: InputDecoration(
                      labelText: 'Categoria',
                      labelStyle: TextStyle(color: themeProvider.textSecondaryColor),
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: themeProvider.textSecondaryColor),
                      ),
                    ),
                    style: TextStyle(color: themeProvider.textColor),
                    validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                    onSaved: (value) => _category = value!,
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: entry?.date ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.dark(
                                primary: themeProvider.primaryColor,
                                onPrimary: themeProvider.menuColor,
                                surface: themeProvider.cardColor,
                                onSurface: themeProvider.textColor,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (selectedDate != null) {
                        setState(() {
                          _date = selectedDate;
                        });
                      }
                    },
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Data',
                        labelStyle: TextStyle(color: themeProvider.textSecondaryColor),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: themeProvider.textSecondaryColor),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            entry?.date.toString().split(' ')[0] ?? _date.toString().split(' ')[0],
                            style: TextStyle(color: themeProvider.textColor),
                          ),
                          Icon(Icons.calendar_today, color: themeProvider.iconColor),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar', style: TextStyle(color: themeProvider.primaryColor)),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text(entry == null ? 'Adicionar' : 'Salvar'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final updatedEntry = FinancialEntry(
                    id: entry?.id,
                    description: _description,
                    amount: _amount,
                    date: _date,
                    category: _category,
                    type: widget.type,
                  );
                  if (entry == null) {
                    Provider.of<FinancialProvider>(context, listen: false).addEntry(updatedEntry);
                  } else {
                    Provider.of<FinancialProvider>(context, listen: false).updateEntry(updatedEntry);
                  }
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: themeProvider.primaryColor,
                foregroundColor: themeProvider.menuColor,
              ),
            ),
          ],
        );
      },
    );
  }
}

