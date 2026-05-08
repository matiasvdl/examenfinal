import 'package:flutter/material.dart';

import '../models/categoria.dart';
import 'estilo_card.dart';

class CategoriaCard extends StatelessWidget {
  final Categoria categoria;
  final VoidCallback onVer;
  final VoidCallback onEditar;
  final VoidCallback onEliminar;

  const CategoriaCard({
    super.key,
    required this.categoria,
    required this.onVer,
    required this.onEditar,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    return EstiloCard(
      child: ListTile(
        leading: const Icon(Icons.category),
        title: Text(categoria.nombre),
        subtitle: Text('Estado: ${categoria.estado}'),
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