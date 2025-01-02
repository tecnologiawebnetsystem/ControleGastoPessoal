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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final entry = FinancialEntry(
        description: _description,
        amount: _amount,
        date: _date,
        category: _category,
        type: widget.type,
      );
      Provider.of<FinancialProvider>(context, listen: false).addEntry(entry);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final financialProvider = Provider.of<FinancialProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: themeProvider.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: financialProvider.getEntriesByType(widget.type).length,
                itemBuilder: (context, index) {
                  final entry = financialProvider.getEntriesByType(widget.type)[index];
                  return ListTile(
                    title: Text(entry.description),
                    subtitle: Text('${entry.category} - ${entry.date.toString().split(' ')[0]}'),
                    trailing: Text(
                      'R\$ ${entry.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: entry.type == 'income' ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () => _showEntryDialog(entry),
                  );
                },
              ),
            ),
            ElevatedButton(
              child: Text('Adicionar ${widget.title}'),
              onPressed: () => _showEntryDialog(null),
              style: ElevatedButton.styleFrom(
                primary: themeProvider.primaryColor,
                onPrimary: themeProvider.menuColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEntryDialog(FinancialEntry? entry) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(entry == null ? 'Adicionar ${widget.title}' : 'Editar ${widget.title}'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: entry?.description,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                  onSaved: (value) => _description = value!,
                ),
                TextFormField(
                  initialValue: entry?.amount.toString(),
                  decoration: const InputDecoration(labelText: 'Valor'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                  onSaved: (value) => _amount = double.parse(value!),
                ),
                TextFormField(
                  initialValue: entry?.category,
                  decoration: const InputDecoration(labelText: 'Categoria'),
                  validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                  onSaved: (value) => _category = value!,
                ),
                InkWell(
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: entry?.date ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _date = selectedDate;
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(labelText: 'Data'),
                    child: Text(
                      entry?.date.toString().split(' ')[0] ?? _date.toString().split(' ')[0],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
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
            ),
          ],
        );
      },
    );
  }
}

