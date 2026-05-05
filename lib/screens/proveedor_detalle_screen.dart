import 'package:flutter/material.dart';

import '../models/proveedor.dart';
import '../widgets/appbar.dart';

class ProveedorDetalleScreen extends StatelessWidget {
  const ProveedorDetalleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final proveedor =
        ModalRoute.of(context)!.settings.arguments as Proveedor;

    return Scaffold(
      appBar: const AppBarWidget(title: 'Detalle proveedor'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 3,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  proveedor.nombre,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text('Correo: ${proveedor.correo}'),
                const SizedBox(height: 8),
                Text('Teléfono: ${proveedor.telefono}'),
                const SizedBox(height: 8),
                Text('Dirección: ${proveedor.direccion}'),
                const SizedBox(height: 8),
                Text('Estado: ${proveedor.estado}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}