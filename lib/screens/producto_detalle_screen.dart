import 'package:flutter/material.dart';

import '../models/producto_response.dart';
import '../widgets/appbar.dart';
import '../widgets/estilo_card.dart';

class ProductoDetalleScreen extends StatelessWidget {
  const ProductoDetalleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final producto = ModalRoute.of(context)!.settings.arguments as Producto;

    return Scaffold(
      appBar: const AppBarWidget(title: 'Detalle producto'),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: EstiloCard(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    producto.imagen,
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.image_not_supported,
                        size: 80,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  producto.nombre,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text('Precio: \$${producto.precio}'),
                const SizedBox(height: 8),
                Text('Estado: ${producto.estado}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}