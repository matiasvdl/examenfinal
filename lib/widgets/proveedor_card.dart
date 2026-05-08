import 'package:flutter/material.dart';

import '../models/proveedor.dart';
import 'estilo_card.dart';

class ProveedorCard extends StatelessWidget {
  final Proveedor proveedor;
  final VoidCallback onVer;
  final VoidCallback onEditar;
  final VoidCallback onEliminar;

  const ProveedorCard({
    super.key,
    required this.proveedor,
    required this.onVer,
    required this.onEditar,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    return EstiloCard(
      child: ListTile(
        leading: const Icon(Icons.local_shipping),
        title: Text('${proveedor.nombre} ${proveedor.apellido}'),
        subtitle: Text(proveedor.correo),
        onTap: onVer,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEditar,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onEliminar,
            ),
          ],
        ),
      ),
    );
  }
}