import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailScreen extends StatefulWidget {
  final String message;

  const EmailScreen({Key? key, required this.message}) : super(key: key);

  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enviar por E-mail'),
        backgroundColor: themeProvider.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'E-mail do destinatário',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um e-mail';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Por favor, insira um e-mail válido';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Enviar E-mail'),
                onPressed: _sendEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeProvider.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendEmail() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: _email,
        queryParameters: {
          'subject': 'Informação de Lançamento Financeiro',
          'body': widget.message,
        },
      );

      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível abrir o aplicativo de e-mail')),
        );
      }
    }
  }
}

