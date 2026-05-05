import 'package:flutter/material.dart';

import '../models/categoria.dart';
import '../widgets/appbar.dart';
import '../widgets/estilo_card.dart';

class CategoriaDetalleScreen extends StatelessWidget {
  const CategoriaDetalleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoria = ModalRoute.of(context)!.settings.arguments as Categoria;

    return Scaffold(
      appBar: const AppBarWidget(title: 'Detalle categoría'),
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
                  categoria.nombre,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text('Descripción: ${categoria.descripcion}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}