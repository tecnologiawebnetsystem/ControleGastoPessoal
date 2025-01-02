import 'package:flutter/material.dart';

class ContasScreen extends StatelessWidget {
  const ContasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Cadastro de Contas',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

