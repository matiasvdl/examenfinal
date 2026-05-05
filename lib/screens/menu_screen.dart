import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/appbar.dart';
import '../widgets/estilo_card.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    if (context.mounted) {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Módulos',
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          EstiloCard(
            child: ListTile(
              leading: const Icon(Icons.local_shipping),
              title: const Text(
                'Proveedores',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text(
                'Ver, editar y eliminar proveedores',
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pushNamed(context, 'proveedores');
              },
            ),
          ),

          EstiloCard(
            child: ListTile(
              leading: const Icon(Icons.category),
              title: const Text(
                'Categorías',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text(
                'Ver, editar y eliminar categorías',
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pushNamed(context, 'categorias');
              },
            ),
          ),

          EstiloCard(
            child: ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text(
                'Productos',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text(
                'Ver, editar y eliminar productos',
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pushNamed(context, 'productos');
              },
            ),
          ),
        ],
      ),
    );
  }
}