import 'package:flutter/material.dart';

class BancosScreen extends StatelessWidget {
  const BancosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Cadastro de Bancos',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

