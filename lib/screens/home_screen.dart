import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../providers/producto_provider.dart';
import '../widgets/appbar.dart';
import '../widgets/producto_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    if (context.mounted) {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }

  void _showDeleteDialog(
    BuildContext context,
    ProductoProvider productoProvider,
    int id,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar'),
        content: const Text('¿Eliminar este producto?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              await productoProvider.eliminarProducto(id);

              if (context.mounted) {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Producto eliminado'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productoProvider = Provider.of<ProductoProvider>(context);
    final listado = productoProvider.listadoProductos;

    return Scaffold(
      appBar: AppBarWidget(
        title: 'Productos',
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'producto_formulario');
        },
      ),
      body: productoProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : listado.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inventory,
                        size: 60,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'No hay productos disponibles',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: listado.length,
                  itemBuilder: (context, index) {
                    final producto = listado[index];

                    return ProductoCard(
                      producto: producto,
                      onVer: () {
                        Navigator.pushNamed(
                          context,
                          'producto_detalle',
                          arguments: producto,
                        );
                      },
                      onEdit: () {
                        Navigator.pushNamed(
                          context,
                          'producto_formulario',
                          arguments: producto,
                        );
                      },
                      onDelete: () {
                        _showDeleteDialog(
                          context,
                          productoProvider,
                          producto.id,
                        );
                      },
                    );
                  },
                ),
    );
  }
}