import 'package:flutter/material.dart';

import '../models/proveedor.dart';
import '../widgets/appbar.dart';
import '../widgets/estilo_card.dart';

class ProveedorDetalleScreen extends StatelessWidget {
  const ProveedorDetalleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final proveedor = ModalRoute.of(context)!.settings.arguments as Proveedor;

    return Scaffold(
      appBar: const AppBarWidget(title: 'Detalle proveedor'),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: EstiloCard(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${proveedor.nombre} ${proveedor.apellido}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text('Correo: ${proveedor.correo}'),
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