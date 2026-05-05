import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/proveedor_provider.dart';
import '../widgets/appbar.dart';
import '../widgets/proveedor_card.dart';

class ProveedoresScreen extends StatelessWidget {
  const ProveedoresScreen({super.key});

  void _confirmarEliminar(
    BuildContext context,
    ProveedorProvider proveedorProvider,
    String id,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar'),
        content: const Text('¿Eliminar este proveedor?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              proveedorProvider.eliminarProveedor(id);
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Proveedor eliminado'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final proveedorProvider = Provider.of<ProveedorProvider>(context);
    final proveedores = proveedorProvider.proveedores;

    return Scaffold(
      appBar: const AppBarWidget(title: 'Proveedores'),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'proveedor_formulario');
        },
      ),
      body: proveedores.isEmpty
          ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.local_shipping,
                  size: 60,
                  color: Colors.grey,
                ),
                SizedBox(height: 10),
                Text(
                  'No hay proveedores disponibles',
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
              itemCount: proveedores.length,
              itemBuilder: (context, index) {
                final proveedor = proveedores[index];

                return ProveedorCard(
                  proveedor: proveedor,
                  onVer: () {
                    Navigator.pushNamed(
                      context,
                      'proveedor_detalle',
                      arguments: proveedor,
                    );
                  },
                  onEditar: () {
                    Navigator.pushNamed(
                      context,
                      'proveedor_formulario',
                      arguments: proveedor,
                    );
                  },
                  onEliminar: () {
                    _confirmarEliminar(
                      context,
                      proveedorProvider,
                      proveedor.id,
                    );
                  },
                );
              },
            ),
    );
  }
}