import 'package:flutter/material.dart';

import '../models/producto_response.dart';
import 'estilo_card.dart';

class ProductoCard extends StatelessWidget {
  final Producto producto;
  final VoidCallback onVer;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductoCard({
    super.key,
    required this.producto,
    required this.onVer,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return EstiloCard(
      child: ListTile(
        onTap: onVer,
        leading: Image.network(
          producto.imagen,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.image_not_supported);
          },
        ),
        title: Text(producto.nombre),
        subtitle: Text('\$${producto.precio}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}