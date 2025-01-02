import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final Function(String) onScreenChange;

  const CustomDrawer({Key? key, required this.onScreenChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Caixinha',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Orçamento'),
            onTap: () => onScreenChange('Orçamento'),
          ),
          ExpansionTile(
            title: const Text('Cadastro'),
            children: <Widget>[
              ListTile(
                title: const Text('Contas'),
                onTap: () => onScreenChange('Contas'),
              ),
              ListTile(
                title: const Text('Bancos'),
                onTap: () => onScreenChange('Bancos'),
              ),
            ],
          ),
          ListTile(
            title: const Text('Contas a Pagar'),
            onTap: () => onScreenChange('Contas a Pagar'),
          ),
          ListTile(
            title: const Text('Contas a Receber'),
            onTap: () => onScreenChange('Contas a Receber'),
          ),
        ],
      ),
    );
  }
}