import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'home_screen.dart';
import 'cadastro_screen.dart';
import 'recuperar_senha_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: size.width > 1200 ? 1000 : size.width * 0.9,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: themeProvider.cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bem-vindo ao',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                              color: themeProvider.textColor,
                            ),
                          ),
                          Text(
                            'Controle Gasto Pessoal',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: themeProvider.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Gerencie suas finanças com eficiência e precisão.',
                            style: TextStyle(
                              fontSize: 16,
                              color: themeProvider.textColor.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (size.width > 600) ...[
                      const SizedBox(width: 64),
                      Expanded(
                        child: Image.asset(
                          'lib/images/finance_illustration.jpg',
                          height: 200,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 48),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email, color: themeProvider.iconColor),
                    labelStyle: TextStyle(color: themeProvider.textSecondaryColor),
                  ),
                  style: TextStyle(color: themeProvider.textColor),
                ),
                const SizedBox(height: 16),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock, color: themeProvider.iconColor),
                    labelStyle: TextStyle(color: themeProvider.textSecondaryColor),
                  ),
                  style: TextStyle(color: themeProvider.textColor),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeProvider.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Entrar', style: TextStyle(fontSize: 18)),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RecuperarSenhaScreen()),
                        );
                      },
                      child: Text(
                        'Esqueceu a senha?',
                        style: TextStyle(color: themeProvider.primaryColor),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CadastroScreen()),
                        );
                      },
                      child: Text(
                        'Criar uma conta',
                        style: TextStyle(color: themeProvider.primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

